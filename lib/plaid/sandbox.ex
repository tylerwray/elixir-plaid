defmodule Plaid.Sandbox do
  @moduledoc """
  [Plaid Sandbox API](https://plaid.com/docs/api/sandbox/) calls and schema.

  > Only used for sandbox testing purposes. None of these calls will work in `development` or `production`.
  """

  alias Plaid.Castable

  defmodule TransactionsOptions do
    @moduledoc """
    [Plaid API /sandbox/public_token/create transactions options schema.](https://plaid.com/docs/api/sandbox/#sandbox-public_token-create-request-transactions)
    """

    @type t :: %__MODULE__{
            start_date: String.t(),
            end_date: String.t()
          }

    @derive Jason.Encoder
    defstruct [:start_date, :end_date]
  end

  defmodule CreatePublicTokenResponse do
    @moduledoc """
    [Plaid API /sandbox/public_token/create response schema.](https://plaid.com/docs/api/sandbox/#sandboxpublic_tokencreate)
    """

    @behaviour Castable

    @type t :: %__MODULE__{
            public_token: String.t(),
            request_id: String.t()
          }

    defstruct [:public_token, :request_id]

    @impl true
    def cast(generic_map) do
      %__MODULE__{
        public_token: generic_map["public_token"],
        request_id: generic_map["request_id"]
      }
    end
  end

  @doc """
  Create a valid `public_token` with arbitrary details.

  Does a `POST /sandbox/public_token/create` call to create a new
  sandbox public token.

  Params:
  * `institution_id` - The ID of the institution the Item will be associated with.
  * `initial_products` - The products to initially pull for the Item. 

  Options:
  * `:webhook` - Specify a webhook to associate with the new Item.
  * `:override_username` - Test username to use for the creation of the Sandbox Item.
  * `:override_password` - Test password to use for the creation of the Sandbox Item.
  * `:transactions` - Options for transactions on the new Item.

  ## Examples

      Sandbox.create_public_token("ins_1", ["auth"], client_id: "123", secret: "abc")
      {:ok, %Sandbox.CreatePublicTokenResponse{}}

  """
  @spec create_public_token(String.t(), [String.t()], options, Plaid.config()) ::
          {:ok, CreatePublicTokenResponse.t()} | {:error, Plaid.Error.t()}
        when options: %{
               optional(:webhook) => String.t(),
               optional(:override_username) => String.t(),
               optional(:override_password) => String.t(),
               optional(:transactions) => TransactionsOptions.t()
             }
  def create_public_token(institution_id, initial_products, options \\ %{}, config) do
    options_payload =
      Map.take(options, [:webhook, :override_username, :override_password, :transactions])

    payload =
      %{}
      |> Map.put(:institution_id, institution_id)
      |> Map.put(:initial_products, initial_products)
      |> Map.put(:options, options_payload)

    Plaid.Client.call(
      "/sandbox/public_token/create",
      payload,
      CreatePublicTokenResponse,
      config
    )
  end

  defmodule ResetItemLoginResponse do
    @moduledoc """
    [Plaid API /sandbox/item/reset_login response schema.](https://plaid.com/docs/api/sandbox/#sandboxitemreset_login)
    """

    @behaviour Castable

    @type t :: %__MODULE__{
            reset_login: boolean(),
            request_id: String.t()
          }

    defstruct [:reset_login, :request_id]

    @impl true
    def cast(generic_map) do
      %__MODULE__{
        reset_login: generic_map["reset_login"],
        request_id: generic_map["request_id"]
      }
    end
  end

  @doc """
  Force an item into a "login required" state.

  Does a `POST /sandbox/item/reset_login` call which forces an item into the
  `ITEM_LOGIN_REQUIRED` state to simulate and item whose login is no longer valid.

  Params:
  * `access_token` - The access token associated with the Item to reset the login for.

  ## Examples

      Sandbox.reset_item_login("access-prod-123xxx", client_id: "123", secret: "abc")
      {:ok, %Sandbox.ResetItemLoginResponse{}}

  """
  @spec reset_item_login(String.t(), Plaid.config()) ::
          {:ok, ResetItemLoginResponse.t()} | {:error, Plaid.Error.t()}
  def reset_item_login(access_token, config) do
    Plaid.Client.call(
      "/sandbox/item/reset_login",
      %{access_token: access_token},
      ResetItemLoginResponse,
      config
    )
  end

  @doc """
  Change the verification status of an item.

  Does a `POST /sandbox/item/set_verification_status` call to change the
  status of an item in order to simulate the Automated Micro-deposit flow.

  Params:
  * `access_token` - The access token associated with the Item data is being requested for.
  * `account_id` - The ID of the account whose verification status is to be modified.
  * `verification_status` - The verification status to set the account to.

  ## Examples

      Sandbox.set_item_verification_status("access-prod-123xxx", "39flxk4ek2xs", "verification_expired", client_id: "123", secret: "abc")
      {:ok, %Plaid.SimpleResponse{request_id: "9bkemelske"}}

  """
  @spec set_item_verification_status(String.t(), String.t(), String.t(), Plaid.config()) ::
          {:ok, Plaid.SimpleResponse.t()} | {:error, Plaid.Error.t()}
  def set_item_verification_status(access_token, account_id, verification_status, config) do
    payload = %{
      access_token: access_token,
      account_id: account_id,
      verification_status: verification_status
    }

    Plaid.Client.call(
      "/sandbox/item/set_verification_status",
      payload,
      Plaid.SimpleResponse,
      config
    )
  end

  defmodule FireItemWebhookResponse do
    @moduledoc """
    [Plaid API /sandbox/item/fire_webhook response schema.](https://plaid.com/docs/api/sandbox/#sandboxitemfire_webhook)
    """

    @behaviour Castable

    @type t :: %__MODULE__{
            webhook_fired: boolean(),
            request_id: String.t()
          }

    defstruct [:webhook_fired, :request_id]

    @impl true
    def cast(generic_map) do
      %__MODULE__{
        webhook_fired: generic_map["webhook_fired"],
        request_id: generic_map["request_id"]
      }
    end
  end

  @doc """
  Fire a fake webhook to an Item's webhook endpoint.

  Does a `POST /sandbox/item/fire_webhook` call which forces an item into the
  ITEM_LOGIN_REQUIRED state to simulate and item whose login is no longer valid.

  Params:
  * `access_token` - The access token associated with the Item to fire the webhook for.
  * `webhook_code` - The webhook code to send.

  > `webhook_code` only supports `DEFAULT_UPDATE` for now.

  ## Examples

      Sandbox.fire_item_webhook("access-prod-123xxx", "DEFAULT_UPDATE", client_id: "123", secret: "abc")
      {:ok, %Sandbox.FireItemWebhookResponse{}}

  """
  @spec fire_item_webhook(String.t(), String.t(), Plaid.config()) ::
          {:ok, FireItemWebhookResponse.t()} | {:error, Plaid.Error.t()}
  def fire_item_webhook(access_token, webhook_code, config) do
    Plaid.Client.call(
      "/sandbox/item/fire_webhook",
      %{access_token: access_token, webhook_code: webhook_code},
      FireItemWebhookResponse,
      config
    )
  end

  defmodule CreateProcessorTokenResponse do
    @moduledoc """
    [Plaid API /sandbox/processor_token/create response schema.](https://plaid.com/docs/api/sandbox/#sandboxprocessor_tokencreate)
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
  Create a valid `processor_token` for an arbitrary institution ID and test credentials.

  Does a `POST /sandbox/processor_token/create` call to create a valid `processor_token`
  to use with all the processor endpoints in the sandbox.

  Params:
  * `institution_id` - The ID of the institution the Item will be associated with.

  Options:
  * `:override_username` - Test username to use for the creation of the Sandbox Item.
  * `:override_password` - Test password to use for the creation of the Sandbox Item.

  ## Examples

      Sandbox.create_processor_token("ins_1", client_id: "123", secret: "abc")
      {:ok, %Sandbox.CreateProcessorTokenResponse{}}

  """
  @spec create_processor_token(String.t(), String.t(), Plaid.config()) ::
          {:ok, CreateProcessorTokenResponse.t()} | {:error, Plaid.Error.t()}
  def create_processor_token(institution_id, options \\ %{}, config) do
    options_payload = Map.take(options, [:override_username, :override_password])
    payload = %{institution_id: institution_id, options: options_payload}

    Plaid.Client.call(
      "/sandbox/processor_token/create",
      payload,
      CreateProcessorTokenResponse,
      config
    )
  end
end
