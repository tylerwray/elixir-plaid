defmodule Plaid.Processor do
  @moduledoc """
  [Plaid Processor API](https://plaid.com/docs/api/processors) calls and schema.
  """

  alias Plaid.Castable

  defmodule CreateTokenResponse do
    @moduledoc """
    [Plaid API /processor/token/create response schema.](https://plaid.com/docs/api/processors/#processortokencreate)
    """

    @behaviour Castable

    @type t :: %__MODULE__{
            processor_token: String.t(),
            request_id: String.t()
          }

    defstruct [:processor_token, :request_id]

    @impl true
    def cast(generic_map) do
      %__MODULE__{
        processor_token: generic_map["processor_token"],
        request_id: generic_map["request_id"]
      }
    end
  end

  @doc """
  Creates a processor token from an access_token.

  Does a `POST /processor/token/create` call which generates
  any non-stripe processor token for a given account ID.

  Params:
  * `access_token` - access_token to create a processor token for.
  * `account_id` - ID of the account to create a processor token for.
  * `processor` - name of the processor to create a token for.

  ## Examples

      Processor.create_token("access-prod-123xxx", "blejdkalk3kdlsl", "galileo", client_id: "123", secret: "abc")
      {:ok, %Processor.CreateTokenResponse{}}

  """
  @spec create_token(String.t(), String.t(), String.t(), Plaid.config()) ::
          {:ok, CreateTokenResponse.t()} | {:error, Plaid.Error.t()}
  def create_token(access_token, account_id, processor, config) do
    Plaid.Client.call(
      "/processor/token/create",
      %{access_token: access_token, account_id: account_id, processor: processor},
      CreateTokenResponse,
      config
    )
  end

  defmodule CreateStripeBankAccountTokenResponse do
    @moduledoc """
    [Plaid API /processor/stripe/bank_account_token/create response schema.](https://plaid.com/docs/api/processors/#processorstripebank_account_tokencreate)
    """

    @behaviour Castable

    @type t :: %__MODULE__{
            stripe_bank_account_token: String.t(),
            request_id: String.t()
          }

    defstruct [:stripe_bank_account_token, :request_id]

    @impl true
    def cast(generic_map) do
      %__MODULE__{
        stripe_bank_account_token: generic_map["stripe_bank_account_token"],
        request_id: generic_map["request_id"]
      }
    end
  end

  @doc """
  Creates a stripe bank account token from an access_token.

  Does a POST `/processor/stripe/bank_account_token/create` call which
  generates a stripe bank account token for a given account ID.

  Params:
  * `access_token` - access_token to create a processor token for.
  * `account_id` - ID of the account to create a processor token for.

  ## Examples

      Processor.create_stripe_bank_account_token("access-prod-123xxx", "blejdkalk3kdlsl", client_id: "123", secret: "abc")
      {:ok, %Processor.CreateStripeBankAccountTokenResponse{}}

  """
  @spec create_stripe_bank_account_token(String.t(), String.t(), Plaid.config()) ::
          {:ok, CreateStripeBankAccountTokenResponse.t()} | {:error, Plaid.Error.t()}
  def create_stripe_bank_account_token(access_token, account_id, config) do
    Plaid.Client.call(
      "/processor/stripe/bank_account_token/create",
      %{access_token: access_token, account_id: account_id},
      CreateStripeBankAccountTokenResponse,
      config
    )
  end

  defmodule GetAuthResponse do
    @moduledoc """
    [Plaid API /processor/auth/get response schema.](https://plaid.com/docs/api/processors/#processorauthget)
    """

    @behaviour Castable
    alias Plaid.Accounts.Account
    alias Plaid.Processor.Numbers

    @type t :: %__MODULE__{
            account: Account.t(),
            numbers: Numbers.t(),
            request_id: String.t()
          }

    defstruct [:account, :numbers, :request_id]

    @impl true
    def cast(generic_map) do
      %__MODULE__{
        account: Castable.cast(Account, generic_map["account"]),
        numbers: Castable.cast(Numbers, generic_map["numbers"]),
        request_id: generic_map["request_id"]
      }
    end
  end

  @doc """
  Get the bank account info given a processor_token.

  Does a POST `/processor/auth/get` call which returns the bank account and bank
  identification number (such as the routing number, for US accounts), for a checking or
  savings account that's associated with a given processor_token.

  Params:
  * `processor_token` - The processor token obtained from the Plaid integration partner.

  ## Examples

      Processor.get_auth("processor-prod-123xxx", client_id: "123", secret: "abc")
      {:ok, %Processor.GetAuthResponse{}}

  """
  @spec get_auth(String.t(), Plaid.config()) ::
          {:ok, GetAuthResponse.t()} | {:error, Plaid.Error.t()}
  def get_auth(processor_token, config) do
    Plaid.Client.call(
      "/processor/auth/get",
      %{processor_token: processor_token},
      GetAuthResponse,
      config
    )
  end

  defmodule GetBalanceResponse do
    @moduledoc """
    [Plaid API /processor/balance/get response schema.](https://plaid.com/docs/api/processors/#processorbalanceget)
    """

    @behaviour Castable
    alias Plaid.Accounts.Account

    @type t :: %__MODULE__{
            account: Account.t(),
            request_id: String.t()
          }

    defstruct [:account, :request_id]

    @impl true
    def cast(generic_map) do
      %__MODULE__{
        account: Castable.cast(Account, generic_map["account"]),
        request_id: generic_map["request_id"]
      }
    end
  end

  @doc """
  Get real-time balance for each of an Item's accounts.

  Does a POST `/processor/balance/get` call which returns the balance for each of a Item's
  accounts.

  While other endpoints may return a balance object, only /processor/balance/get
  forces the available and current balance fields to be refreshed rather than cached.

  Params:
  * `processor_token` - The processor token obtained from the Plaid integration partner.

  ## Examples

      Processor.get_balance("processor-prod-123xxx", client_id: "123", secret: "abc")
      {:ok, %Processor.GetBalanceResponse{}}

  """
  @spec get_balance(String.t(), Plaid.config()) ::
          {:ok, GetBalanceResponse.t()} | {:error, Plaid.Error.t()}
  def get_balance(processor_token, config) do
    Plaid.Client.call(
      "/processor/balance/get",
      %{processor_token: processor_token},
      GetBalanceResponse,
      config
    )
  end

  defmodule GetIdentityResponse do
    @moduledoc """
    [Plaid API /processor/identity/get response schema.](https://plaid.com/docs/api/processors/#processoridentityget)
    """

    @behaviour Castable
    alias Plaid.Accounts.Account

    @type t :: %__MODULE__{
            account: Account.t(),
            request_id: String.t()
          }

    defstruct [:account, :request_id]

    @impl true
    def cast(generic_map) do
      %__MODULE__{
        account: Castable.cast(Account, generic_map["account"]),
        request_id: generic_map["request_id"]
      }
    end
  end

  @doc """
  Get account holder information on file with the financial institution.

  Does a POST `/processor/identity/get` call which allows you to retrieve various
  account holder information on file with the financial institution,
  including names, emails, phone numbers, and addresses.

  Params:
  * `processor_token` - The processor token obtained from the Plaid integration partner.

  ## Examples

      Processor.get_identity("processor-prod-123xxx", client_id: "123", secret: "abc")
      {:ok, %Processor.GetIdentityResponse{}}

  """
  @spec get_identity(String.t(), Plaid.config()) ::
          {:ok, GetIdentityResponse.t()} | {:error, Plaid.Error.t()}
  def get_identity(processor_token, config) do
    Plaid.Client.call(
      "/processor/identity/get",
      %{processor_token: processor_token},
      GetIdentityResponse,
      config
    )
  end
end
