defmodule Plaid.Accounts do
  @moduledoc """
  [Plaid Accounts API](https://plaid.com/docs/api/accounts) calls and schema.
  """

  alias Plaid.Castable

  defmodule GetResponse do
    @moduledoc """
    [Plaid API /accounts/get response schema.](https://plaid.com/docs/api/accounts).
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

  Does a `POST /accounts/get` call to retrieve high level account information
  associated with an access_token's item.

  Params:
  * `access_token` - Token to fetch accounts for.

  Options:
  * `:account_ids` - Specific account ids to fetch accounts for.

  ## Examples

      Accounts.get("access-sandbox-123xxx", client_id: "123", secret: "abc")
      {:ok, %Accounts.GetResponse{}}

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

    Plaid.Client.call("/accounts/get", payload, GetResponse, config)
  end

  @doc """
  Get information about all available balances.

  Does a `POST /accounts/balance/get` call to retrieve real-time balance
  information for all accounts associated with an access_token's item.

  This API call will force balances to be refreshed, rather than use
  the cache like other API calls that return balances.

  Params:
  * `access_token` - Token to fetch accounts for.

  Options:
  * `:account_ids` - Specific account ids to fetch balances for.

  ## Examples

      Accounts.get_balance("access-sandbox-123xxx", client_id: "123", secret: "abc")
      {:ok, %Accounts.GetResponse{}}

  """
  @spec get_balance(String.t(), options, Plaid.config()) ::
          {:ok, GetResponse.t()} | {:error, Plaid.Error.t()}
        when options: %{optional(:account_ids) => [String.t()]}
  def get_balance(access_token, options \\ %{}, config) do
    options_payload = Map.take(options, [:account_ids])

    payload =
      %{}
      |> Map.put(:access_token, access_token)
      |> Map.put(:options, options_payload)

    Plaid.Client.call("/accounts/balance/get", payload, GetResponse, config)
  end
end
