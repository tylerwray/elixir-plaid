defmodule Plaid.Webhooks do
  @moduledoc """
  Verify webhooks from plaid and construct the raw body into structs
  """

  require Logger

  alias Plaid.Castable

  @doc """
  Verify that a webhook is actually from plaid, constructing the raw body into an event struct.

  Adheres to the guidelines outlined in [this guide](https://plaid.com/docs/api/webhook-verification/) 
  from plaid to verify webhooks. 

  > 🏗  Only missing piece from the plaid guidelines is public key caching.

  ## Examples

      Webhooks.verify_and_construct(
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c",
        ~s({"webhook_type": "ITEM", "webhook_code": "ERROR"}),
        client_id: "abc",
        secret: "123"
      )
      {:ok, %Webhooks.ItemError{}}

  """
  @spec verify_and_construct(String.t(), String.t(), Plaid.config()) ::
          {:ok, struct()}
          | {:error, :invalid_algorithm | :invalid_body | :unknown | Plaid.Error.t()}
  def verify_and_construct(jwt, raw_body, config) do
    token_config = %{
      "iat" => %Joken.Claim{
        validate: fn issued_at, _, _ ->
          age = DateTime.to_unix(DateTime.utc_now()) - issued_at
          five_minutes = 5 * 60

          age <= five_minutes
        end
      }
    }

    with {:ok, %{"alg" => "ES256", "kid" => kid}} <- Joken.peek_header(jwt),
         {:ok, %{key: key}} <- get_verification_key(kid, config),
         signer = Joken.Signer.create("ES256", key),
         {:ok, %{"request_body_sha256" => claimed_body_hash}} <-
           Joken.verify_and_validate(token_config, jwt, signer),
         true <- SecureCompare.compare(body_hash(raw_body), claimed_body_hash),
         {:ok, %{"webhook_type" => type, "webhook_code" => code} = body} <- Jason.decode(raw_body) do
      {:ok, Plaid.Castable.cast(struct_module(type, code), body)}
    else
      {:ok, %{"alg" => _alg}} ->
        {:error, :invalid_algorithm}

      {:error, %Plaid.Error{} = error} ->
        {:error, error}

      false ->
        {:error, :invalid_body}

      error ->
        Logger.debug("[#{__MODULE__}] unknown error verifying webhook: #{inspect(error)}")
        {:error, :unknown}
    end
  end

  @spec body_hash(String.t()) :: String.t()
  defp body_hash(raw_body) do
    :sha256
    |> :crypto.hash(raw_body)
    |> Base.encode16(padding: false, case: :lower)
  end

  defmodule GetVerificationKeyResponse do
    @moduledoc false
    @behaviour Castable

    @type t :: %__MODULE__{
            key: map(),
            request_id: String.t()
          }

    defstruct [:key, :request_id]

    @impl true
    def cast(generic_map) do
      %__MODULE__{
        # Keeping key as a string-keyed map because
        # that's what Joken.Signer.create/3 requires.
        key: generic_map["key"],
        request_id: generic_map["request_id"]
      }
    end
  end

  @spec get_verification_key(String.t(), Plaid.config()) ::
          {:ok, GetVerificationKeyResponse.t()} | {:error, Plaid.Error.t()}
  defp get_verification_key(key_id, config) do
    Plaid.Client.call(
      "/webhook_verification_key/get",
      %{key_id: key_id},
      GetVerificationKeyResponse,
      config
    )
  end

  defmodule ItemError do
    @moduledoc """
    [Plaid webhooks ITEM: ERROR schema](https://plaid.com/docs/api/webhooks/#item-error)
    """

    @behaviour Castable

    @type t :: %__MODULE__{
            webhook_type: String.t(),
            webhook_code: String.t(),
            item_id: String.t(),
            error: Plaid.Error.t()
          }

    defstruct [:webhook_type, :webhook_code, :item_id, :error]

    @impl true
    def cast(generic_map) do
      %__MODULE__{
        webhook_type: generic_map["webhook_type"],
        webhook_code: generic_map["webhook_code"],
        item_id: generic_map["item_id"],
        error: Castable.cast(Plaid.Error, generic_map["error"])
      }
    end
  end

  defmodule ItemPendingExpiration do
    @moduledoc """
    [Plaid webhooks ITEM: PENDING_EXPIRATION schema](https://plaid.com/docs/api/webhooks/#item-pending_expiration)
    """

    @behaviour Castable

    @type t :: %__MODULE__{
            webhook_type: String.t(),
            webhook_code: String.t(),
            item_id: String.t(),
            consent_expiration_time: String.t()
          }

    defstruct [:webhook_type, :webhook_code, :item_id, :consent_expiration_time]

    @impl true
    def cast(generic_map) do
      %__MODULE__{
        webhook_type: generic_map["webhook_type"],
        webhook_code: generic_map["webhook_code"],
        item_id: generic_map["item_id"],
        consent_expiration_time: generic_map["consent_expiration_time"]
      }
    end
  end

  defmodule ItemUserPermissionRevoked do
    @moduledoc """
    [Plaid webhooks ITEM: USER_PERMISSION_REVOKED schema](https://plaid.com/docs/api/webhooks/#item-user_permission_revoked)
    """

    @behaviour Castable

    @type t :: %__MODULE__{
            webhook_type: String.t(),
            webhook_code: String.t(),
            item_id: String.t(),
            error: Plaid.Error.t()
          }

    defstruct [:webhook_type, :webhook_code, :item_id, :error]

    @impl true
    def cast(generic_map) do
      %__MODULE__{
        webhook_type: generic_map["webhook_type"],
        webhook_code: generic_map["webhook_code"],
        item_id: generic_map["item_id"],
        error: Castable.cast(Plaid.Error, generic_map["error"])
      }
    end
  end

  defmodule ItemWebhookUpdateAcknowledged do
    @moduledoc """
    [Plaid webhooks ITEM: WEBHOOK_UPDATE_ACKNOWLEDGED schema](https://plaid.com/docs/api/webhooks/#item-webhook_update_acknowledged)
    """

    @behaviour Castable

    @type t :: %__MODULE__{
            webhook_type: String.t(),
            webhook_code: String.t(),
            item_id: String.t(),
            error: Plaid.Error.t(),
            new_webhook_url: String.t()
          }

    defstruct [:webhook_type, :webhook_code, :item_id, :error, :new_webhook_url]

    @impl true
    def cast(generic_map) do
      %__MODULE__{
        webhook_type: generic_map["webhook_type"],
        webhook_code: generic_map["webhook_code"],
        item_id: generic_map["item_id"],
        error: Castable.cast(Plaid.Error, generic_map["error"]),
        new_webhook_url: generic_map["new_webhook_url"]
      }
    end
  end

  defmodule TransactionsUpdate do
    @moduledoc """
    [Plaid webhooks transactions update schema](https://plaid.com/docs/api/webhooks/#transactions-historical_update)

    Used with `INITIAL_UPDATE`, `HISTORICAL_UPDATE`, and `DEFAULT_UPDATE` webhooks.
    """

    @behaviour Castable

    @type t :: %__MODULE__{
            webhook_type: String.t(),
            webhook_code: String.t(),
            item_id: String.t(),
            error: Plaid.Error.t(),
            new_transactions: number()
          }

    defstruct [:webhook_type, :webhook_code, :item_id, :error, :new_transactions]

    @impl true
    def cast(generic_map) do
      %__MODULE__{
        webhook_type: generic_map["webhook_type"],
        webhook_code: generic_map["webhook_code"],
        item_id: generic_map["item_id"],
        error: Castable.cast(Plaid.Error, generic_map["error"]),
        new_transactions: generic_map["new_transactions"]
      }
    end
  end

  defmodule TransactionsRemoved do
    @moduledoc """
    [Plaid webhooks TRANSACTIONS: TRANSACTIONS_REMOVED schema](https://plaid.com/docs/api/webhooks/#transactions-transactions_removed)
    """

    @behaviour Castable

    @type t :: %__MODULE__{
            webhook_type: String.t(),
            webhook_code: String.t(),
            item_id: String.t(),
            error: Plaid.Error.t(),
            removed_transactions: [String.t()]
          }

    defstruct [:webhook_type, :webhook_code, :item_id, :error, :removed_transactions]

    @impl true
    def cast(generic_map) do
      %__MODULE__{
        webhook_type: generic_map["webhook_type"],
        webhook_code: generic_map["webhook_code"],
        item_id: generic_map["item_id"],
        error: Castable.cast(Plaid.Error, generic_map["error"]),
        removed_transactions: generic_map["removed_transactions"]
      }
    end
  end

  defmodule Auth do
    @moduledoc """
    [Plaid auth webhooks schema](https://plaid.com/docs/api/webhooks/#auth-automatically_verified)

    Used with `AUTOMATICALLY_VERIFIED` and `VERIFICATION_EXPIRED` webhooks.
    """

    @behaviour Castable

    @type t :: %__MODULE__{
            webhook_type: String.t(),
            webhook_code: String.t(),
            item_id: String.t(),
            account_id: String.t()
          }

    defstruct [:webhook_type, :webhook_code, :item_id, :account_id]

    @impl true
    def cast(generic_map) do
      %__MODULE__{
        webhook_type: generic_map["webhook_type"],
        webhook_code: generic_map["webhook_code"],
        item_id: generic_map["item_id"],
        account_id: generic_map["account_id"]
      }
    end
  end

  defmodule AssetsProductReady do
    @moduledoc """
    [Plaid ASSETS: PRODUCT_READY webhooks schema](https://plaid.com/docs/api/webhooks/#assets-product_ready)
    """

    @behaviour Castable

    @type t :: %__MODULE__{
            webhook_type: String.t(),
            webhook_code: String.t(),
            asset_report_id: String.t()
          }

    defstruct [:webhook_type, :webhook_code, :asset_report_id]

    @impl true
    def cast(generic_map) do
      %__MODULE__{
        webhook_type: generic_map["webhook_type"],
        webhook_code: generic_map["webhook_code"],
        asset_report_id: generic_map["asset_report_id"]
      }
    end
  end

  defmodule AssetsError do
    @moduledoc """
    [Plaid ASSETS: ERROR webhooks schema](https://plaid.com/docs/api/webhooks/#assets-error)
    """

    @behaviour Castable

    @type t :: %__MODULE__{
            webhook_type: String.t(),
            webhook_code: String.t(),
            asset_report_id: String.t(),
            error: Plaid.Error.t()
          }

    defstruct [:webhook_type, :webhook_code, :asset_report_id, :error]

    @impl true
    def cast(generic_map) do
      %__MODULE__{
        webhook_type: generic_map["webhook_type"],
        webhook_code: generic_map["webhook_code"],
        asset_report_id: generic_map["asset_report_id"],
        error: Castable.cast(Plaid.Error, generic_map["error"])
      }
    end
  end

  defmodule HoldingsUpdate do
    @moduledoc """
    [Plaid HOLDINGS: DEFAULT_UPDATE webhooks schema](https://plaid.com/docs/api/webhooks/#holdings-default_update)
    """

    @behaviour Castable

    @type t :: %__MODULE__{
            webhook_type: String.t(),
            webhook_code: String.t(),
            item_id: String.t(),
            error: Plaid.Error.t(),
            new_holdings: number(),
            updated_holdings: number()
          }

    defstruct [:webhook_type, :webhook_code, :item_id, :error, :new_holdings, :updated_holdings]

    @impl true
    def cast(generic_map) do
      %__MODULE__{
        webhook_type: generic_map["webhook_type"],
        webhook_code: generic_map["webhook_code"],
        item_id: generic_map["item_id"],
        error: Castable.cast(Plaid.Error, generic_map["error"]),
        new_holdings: generic_map["new_holdings"],
        updated_holdings: generic_map["updated_holdings"]
      }
    end
  end

  defmodule InvestmentsTransactionsUpdate do
    @moduledoc """
    [Plaid INVESTMENTS_TRANSACTIONS: DEFAULT_UPDATE webhooks schema](https://plaid.com/docs/api/webhooks/#investments_transactions-default_update)
    """

    @behaviour Castable

    @type t :: %__MODULE__{
            webhook_type: String.t(),
            webhook_code: String.t(),
            item_id: String.t(),
            error: Plaid.Error.t(),
            new_investments_transactions: number(),
            canceled_investments_transactions: number()
          }

    defstruct [
      :webhook_type,
      :webhook_code,
      :item_id,
      :error,
      :new_investments_transactions,
      :canceled_investments_transactions
    ]

    @impl true
    def cast(generic_map) do
      %__MODULE__{
        webhook_type: generic_map["webhook_type"],
        webhook_code: generic_map["webhook_code"],
        item_id: generic_map["item_id"],
        error: Castable.cast(Plaid.Error, generic_map["error"]),
        new_investments_transactions: generic_map["new_investments_transactions"],
        canceled_investments_transactions: generic_map["canceled_investments_transactions"]
      }
    end
  end

  defmodule PaymentInitiationPaymentStatusUpdate do
    @moduledoc """
    [Plaid PAYMENT_INITIATION: PAYMENT_STATUS_UPDATE webhook schema](https://plaid.com/docs/api/webhooks/#payment-initiation-webhooks)
    """

    @behaviour Castable

    @type t :: %__MODULE__{
            webhook_type: String.t(),
            webhook_code: String.t(),
            payment_id: String.t(),
            error: Plaid.Error.t(),
            new_payment_status: String.t(),
            old_payment_status: String.t(),
            original_reference: String.t(),
            adjusted_reference: String.t(),
            original_start_date: String.t(),
            adjusted_start_date: String.t(),
            timestamp: String.t()
          }

    defstruct [
      :webhook_type,
      :webhook_code,
      :payment_id,
      :error,
      :new_payment_status,
      :old_payment_status,
      :original_reference,
      :adjusted_reference,
      :original_start_date,
      :adjusted_start_date,
      :timestamp
    ]

    @impl true
    def cast(generic_map) do
      %__MODULE__{
        webhook_type: generic_map["webhook_type"],
        webhook_code: generic_map["webhook_code"],
        payment_id: generic_map["payment_id"],
        error: Castable.cast(Plaid.Error, generic_map["error"]),
        new_payment_status: generic_map["new_payment_status"],
        old_payment_status: generic_map["old_payment_status"],
        original_reference: generic_map["original_reference"],
        adjusted_reference: generic_map["adjusted_reference"],
        original_start_date: generic_map["original_start_date"],
        adjusted_start_date: generic_map["adjusted_start_date"],
        timestamp: generic_map["timestamp"]
      }
    end
  end

  @spec struct_module(String.t(), String.t()) :: module()
  defp struct_module("ITEM", "ERROR"), do: ItemError
  defp struct_module("ITEM", "PENDING_EXPIRATION"), do: ItemPendingExpiration
  defp struct_module("ITEM", "USER_PERMISSION_REVOKED"), do: ItemUserPermissionRevoked
  defp struct_module("ITEM", "WEBHOOK_UPDATE_ACKNOWLEDGED"), do: ItemWebhookUpdateAcknowledged
  defp struct_module("TRANSACTIONS", "INITIAL_UPDATE"), do: TransactionsUpdate
  defp struct_module("TRANSACTIONS", "HISTORICAL_UPDATE"), do: TransactionsUpdate
  defp struct_module("TRANSACTIONS", "DEFAULT_UPDATE"), do: TransactionsUpdate
  defp struct_module("TRANSACTIONS", "TRANSACTIONS_REMOVED"), do: TransactionsRemoved
  defp struct_module("AUTH", "AUTOMATICALLY_VERIFIED"), do: Auth
  defp struct_module("AUTH", "VERIFICATION_EXPIRED"), do: Auth
  defp struct_module("ASSETS", "PRODUCT_READY"), do: AssetsProductReady
  defp struct_module("ASSETS", "ERROR"), do: AssetsError
  defp struct_module("HOLDINGS", "DEFAULT_UPDATE"), do: HoldingsUpdate

  defp struct_module("INVESTMENTS_TRANSACTIONS", "DEFAULT_UPDATE"),
    do: InvestmentsTransactionsUpdate

  defp struct_module("PAYMENT_INITIATION", "PAYMENT_STATUS_UPDATE"),
    do: PaymentInitiationPaymentStatusUpdate

  defp struct_module(webhook_type, webhook_code) do
    Logger.warning([
      "[#{__MODULE__}]",
      " webhook cast not implemented for",
      " webhook_type: #{webhook_type} and webhook_code: #{webhook_code}.",
      " Returning raw webhook.",
      " Create an issue or pull request at https://github.com/tylerwray/elixir-plaid."
    ])

    :raw
  end
end
