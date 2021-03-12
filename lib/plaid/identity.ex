defmodule Plaid.Identity do
  @moduledoc """
  [Plaid Identity API](https://plaid.com/docs/api/products/#identity) calls and schema.
  """

  @behaviour Plaid.Castable

  alias Plaid.Castable
  alias Plaid.Identity.{Address, Email, PhoneNumber}

  @type t :: %__MODULE__{
          addresses: [Address.t()],
          emails: [Email.t()],
          names: [String.t()],
          phone_numbers: [PhoneNumber.t()]
        }

  defstruct [:addresses, :emails, :names, :phone_numbers]

  @impl true
  def cast(generic_map) do
    %__MODULE__{
      addresses: Castable.cast_list(Address, generic_map["addresses"]),
      emails: Castable.cast_list(Email, generic_map["emails"]),
      names: generic_map["names"],
      phone_numbers: Castable.cast_list(PhoneNumber, generic_map["phone_numbers"])
    }
  end

  defmodule GetResponse do
    @moduledoc """
    [Plaid API /identity/get response schema.](https://plaid.com/docs/api/accounts).
    """

    @behaviour Castable

    alias Plaid.Accounts.Account
    alias Plaid.Item

    @type t :: %__MODULE__{
            accounts: [Account.t()],
            item: Item.t(),
            request_id: String.t()
          }

    defstruct [:accounts, :item, :request_id]

    @impl true
    def cast(generic_map) do
      %__MODULE__{
        accounts: Castable.cast_list(Account, generic_map["accounts"]),
        item: Castable.cast(Item, generic_map["item"]),
        request_id: generic_map["request_id"]
      }
    end
  end

  @doc """
  Get information about all available accounts.

  Does a `POST /identity/get` call to retrieve account information,
  along with the `owners` info for each account associated with an access_token's item.

  Params:
  * `access_token` - Token to fetch identity for.

  Options:
  * `:account_ids` - Specific account ids to fetch identity for.

  ## Examples

      Identity.get("access-sandbox-123xxx", client_id: "123", secret: "abc")
      {:ok, %Identity.GetResponse{}}

  """
  @spec get(String.t(), options, Plaid.config()) ::
          {:ok, GetResponse.t()} | {:error, Plaid.Error.t()}
        when options: %{optional(:account_ids) => [String.t()]}
  def get(access_token, options \\ %{}, config) do
    options_payload = Map.take(options, [:account_ids])

    payload =
      %{}
      |> Map.put(:access_token, access_token)
      |> Map.put(:options, options_payload)

    Plaid.Client.call("/identity/get", payload, GetResponse, config)
  end
end
