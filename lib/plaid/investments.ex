defmodule Plaid.Investments do
  @moduledoc """
  [Plaid Investments APIs](https://plaid.com/docs/api/products/#investments)
  """

  alias Plaid.Castable

  defmodule GetHoldingsResponse do
    @moduledoc """
    [Plaid API /investments/holdings/get response schema](https://plaid.com/docs/api/products/#investmentsholdingsget)
    """

    @behaviour Castable

    alias Plaid.Accounts.Account
    alias Plaid.Investments.{Holding, Security}
    alias Plaid.Item

    @type t :: %__MODULE__{
            accounts: [Account.t()],
            holdings: [Holding.t()],
            securities: [Security.t()],
            item: Item.t(),
            request_id: String.t()
          }

    defstruct [
      :accounts,
      :holdings,
      :securities,
      :item,
      :request_id
    ]

    @impl true
    def cast(generic_map) do
      %__MODULE__{
        accounts: Castable.cast_list(Account, generic_map["accounts"]),
        holdings: Castable.cast_list(Holding, generic_map["holdings"]),
        securities: Castable.cast_list(Security, generic_map["securities"]),
        item: Castable.cast(Item, generic_map["item"]),
        request_id: generic_map["request_id"]
      }
    end
  end

  @doc """
  Get user-authorized stock position data for investment-type accounts.

  Does a `POST /investments/holdings/get` call to retrieve
  invesment holdings associated with an access_token's item.

  Params:
  * `access_token` - Token to fetch investment holdings for.

  Options:
  * `account_ids` - Specific account ids to fetch investment holdings for.

  ## Examples

      get_holdings("access-sandbox-123xxx", client_id: "123", secret: "abc")
      {:ok, %GetHoldingsResponse{}}

  """
  @spec get_holdings(String.t(), options, Plaid.config()) ::
          {:ok, GetHoldingsResponse.t()} | {:error, Plaid.Error.t()}
        when options: %{optional(:account_ids) => [String.t()]}
  def get_holdings(access_token, options \\ %{}, config) do
    options_payload = Map.take(options, [:account_ids])

    payload = %{access_token: access_token, options: options_payload}

    Plaid.Client.call(
      "/investments/holdings/get",
      payload,
      GetHoldingsResponse,
      config
    )
  end

  defmodule GetTransactionsResponse do
    @moduledoc """
    [Plaid API /investments/transactions/get response schema](https://plaid.com/docs/api/products/#investmentstransactionsget)
    """

    @behaviour Castable

    alias Plaid.Accounts.Account
    alias Plaid.Investments.{Security, Transaction}
    alias Plaid.Item

    @type t :: %__MODULE__{
            item: Item.t(),
            accounts: [Account.t()],
            securities: [Security.t()],
            investment_transactions: [Transaction.t()],
            total_investment_transactions: integer(),
            request_id: String.t()
          }

    defstruct [
      :item,
      :accounts,
      :securities,
      :investment_transactions,
      :total_investment_transactions,
      :request_id
    ]

    @impl true
    def cast(generic_map) do
      %__MODULE__{
        item: Castable.cast(Item, generic_map["item"]),
        accounts: Castable.cast_list(Account, generic_map["accounts"]),
        securities: Castable.cast_list(Security, generic_map["securities"]),
        investment_transactions:
          Castable.cast_list(Transaction, generic_map["investment_transactions"]),
        total_investment_transactions: generic_map["total_investment_transactions"],
        request_id: generic_map["request_id"]
      }
    end
  end

  @doc """
  Get information about all available investment transactions.

  Does a `POST /investments/transactions/get` call which gives you high level
  account data along with investment transactions and associated securities
  from all investment accounts contained in the access_token's item.

  Params:
  * `access_token` - Token to fetch investment holdings for.
  * `start_date` - Start of query for investment transactions.
  * `end_date`  - End of query for investment transactions.

  Options:
  * `account_ids` - Specific account ids to fetch investment holdings for.
  * `count` - Amount of investment transactions to pull (optional).
  * `offset` - Offset to start pulling investment transactions (optional).

  ## Examples

      get_transactions("access-sandbox-123xxx", "2020-01-01", "2020-01-31", client_id: "123", secret: "abc")
      {:ok, %GetTransactionsResponse{}}

  """
  @spec get_transactions(String.t(), String.t(), String.t(), options, Plaid.config()) ::
          {:ok, GetTransactionsResponse.t()} | {:error, Plaid.Error.t()}
        when options: %{
               optional(:account_ids) => [String.t()],
               optional(:count) => integer(),
               optional(:offset) => integer()
             }
  def get_transactions(access_token, start_date, end_date, options \\ %{}, config) do
    options_payload = Map.take(options, [:account_ids, :count, :offset])

    payload = %{
      access_token: access_token,
      start_date: start_date,
      end_date: end_date,
      options: options_payload
    }

    Plaid.Client.call(
      "/investments/transactions/get",
      payload,
      GetTransactionsResponse,
      config
    )
  end
end
