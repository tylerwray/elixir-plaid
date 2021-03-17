defmodule Plaid.LinkToken do
  @moduledoc """
  [Pliad link token API](https://plaid.com/docs/api/tokens/) calls and schema.
  """

  alias Plaid.Castable

  alias Plaid.LinkToken.{
    DepositSwitch,
    Metadata,
    PaymentInitiation,
    User
  }

  defmodule CreateResponse do
    @moduledoc """
    [Plaid API /link/token/create response schema.](https://plaid.com/docs/api/tokens/#linktokencreate)
    """

    @behaviour Castable

    @type t :: %__MODULE__{
            link_token: String.t(),
            expiration: String.t(),
            request_id: String.t()
          }

    defstruct [:link_token, :expiration, :request_id]

    @impl true
    def cast(generic_map) do
      %__MODULE__{
        link_token: generic_map["link_token"],
        expiration: generic_map["expiration"],
        request_id: generic_map["request_id"]
      }
    end
  end

  @doc """
  Creates a token for Plaid Link.

  Does a `POST /link/token/create` call which creates a link token which is 
  required to initialize Plaid Link.

  Params:
  * `client_name` - The name of your application, as it should be displayed in Link.
  * `language` - The language that Link should be displayed in.
  * `country_codes` - Array of country codes to launch Link with.
  * `user` - An object specifying information about the end user who will be linking their account.
  * `products` - List of Plaid product(s) you wish to use.
  * `webhook` - The destination URL to which any webhooks should be sent.
  * `access_token` - The access_token associated with the Item to update.
  * `link_customization_name` - The name of the Link customization from the Plaid Dashboard to be applied to Link.
  * `redirect_uri` - A URI indicating the destination where a user should be forwarded after completing the Link flow.
  * `android_package_name` - The name of your app's Android package. Required if initializing android Link.
  * `account_filters` - Filter the accounts shown in Link.
  * `payment_initiation` - For initializing Link for use with the Payment Initiation.
  * `deposit_switch` - For initializing Link for use with the Deposit Switch.

  ## Examples

      LinkToken.create(
        %{
          client_name: "Plaid Test App",
          language: "en",
          country_codes: ["US", "CA"],
          user: %LinkToken.User{
            client_user_id: "123-test-user",
            legal_name: "Test User",
            phone_number: "+19995550123",
            phone_number_verified_time: "2020-01-01T00:00:00Z",
            email_address: "test@example.com",
            email_address_verified_time: "2020-01-01T00:00:00Z",
            ssn: "444-33-2222",
            date_of_birth: "1990-01-01"
          },
          products: ["auth", "transactions"],
          webhook: "https://example.com/webhook",
          access_token: "access-prod-123xxx",
          link_customization_name: "vip-user",
          redirect_uri: "https://example.com/redirect",
          android_package_name: "com.service.user",
          account_filters: %{
            depository: %{
              account_subtypes: ["401k", "529"]
            }
          },
          payment_initiation: %LinkToken.PaymentInitiation{
            payment_id: "payment-id-sandbox-123xxx"
          },
          deposit_switch: %LinkToken.DepositSwitch{
            deposit_switch_id: "deposit-switch-id-sandbox-123xxx"
          }
        },
        test_api_host: api_host,
        client_id: "123",
        secret: "abc"
      )
      {:ok, LinkToken.CreateResponse{}}

  """
  @spec create(payload, Plaid.config()) :: {:ok, CreateResponse.t()} | {:error, Plaid.Error.t()}
        when payload: %{
               :client_name => String.t(),
               :language => String.t(),
               :country_codes => [String.t()],
               :user => User.t(),
               optional(:products) => [String.t()],
               optional(:webhook) => String.t(),
               optional(:access_token) => String.t(),
               optional(:link_customization_name) => String.t(),
               optional(:redirect_uri) => String.t(),
               optional(:android_package_name) => String.t(),
               optional(:account_filters) => map(),
               optional(:payment_initiation) => PaymentInitiation.t(),
               optional(:deposit_switch) => DepositSwitch.t()
             }
  def create(payload, config) do
    Plaid.Client.call("/link/token/create", payload, CreateResponse, config)
  end

  defmodule GetResponse do
    @moduledoc """
    [Plaid API /link/token/get response schema.](https://plaid.com/docs/api/tokens/#linktokenget)
    """

    @behaviour Castable

    @type t :: %__MODULE__{
            created_at: String.t() | nil,
            expiration: String.t() | nil,
            link_token: String.t() | nil,
            metadata: Metadata.t(),
            request_id: String.t()
          }

    defstruct [
      :created_at,
      :link_token,
      :expiration,
      :metadata,
      :request_id
    ]

    @impl true
    def cast(generic_map) do
      %__MODULE__{
        created_at: generic_map["created_at"],
        expiration: generic_map["expiration"],
        link_token: generic_map["link_token"],
        metadata: Castable.cast(Metadata, generic_map["metadata"]),
        request_id: generic_map["request_id"]
      }
    end
  end

  @doc """
  Get information about a previously created link token.

  Does a `POST /link/token/get` call which returns details about a link token which
  was previously created.

  Params:
  * `link_token` - A link_token from a previous invocation of /link/token/create.

  ## Examples

      LinkToken.get("link-prod-123xxx", client_id: "123", secret: "abc")
      {:ok, %Plaid.LinkToken.GetResponse{}}

  """
  @spec get(String.t(), Plaid.config()) :: {:ok, GetResponse.t()} | {:error, Plaid.Error.t()}
  def get(link_token, config) do
    Plaid.Client.call("/link/token/get", %{link_token: link_token}, GetResponse, config)
  end
end
