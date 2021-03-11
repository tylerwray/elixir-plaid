defmodule Plaid.Auth do
  @moduledoc """
  [Plaid Auth API](https://plaid.com/docs/api/products/#auth) calls and schema.
  """

  defmodule GetResponse do
    @moduledoc """
    [Plaid API /auth/get response](https://plaid.com/docs/api/products/#auth).
    """

    @behaviour Plaid.Castable

    alias Plaid.Accounts.Account
    alias Plaid.Auth.Numbers
    alias Plaid.Castable
    alias Plaid.Item

    @type t :: %__MODULE__{
            accounts: [Account.t()],
            numbers: Numbers.t(),
            item: Item.t(),
            request_id: String.t()
          }

    defstruct [
      :accounts,
      :numbers,
      :item,
      :request_id
    ]

    @impl true
    def cast(generic_map) do
      %__MODULE__{
        accounts: Castable.cast_list(Account, generic_map["accounts"]),
        numbers: Castable.cast(Numbers, generic_map["numbers"]),
        item: Castable.cast(Item, generic_map["item"]),
        request_id: generic_map["request_id"]
      }
    end
  end

  @doc """
  Get information about account and routing numbers for
  checking and savings accounts.

  Does a `POST /auth/get` call which returns high level account information
  along with account and routing numbers for checking and savings
  accounts.

  Params:
  * `access_token` - Token to fetch accounts for.

  Options:
  * `account_ids` - Specific account ids to fetch balances for.

  ## Examples

      get("access-sandbox-123xxx", client_id: "123", secret: "abc")
      {:ok, %GetResponse{}}

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

    Plaid.Client.call(
      "/auth/get",
      payload,
      GetResponse,
      config
    )
  end
end
