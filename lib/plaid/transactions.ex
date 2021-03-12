defmodule Plaid.Transactions do
  @moduledoc """
  [Plaid Transactions API](https://plaid.com/docs/api/transactions) calls and schema.
  """

  defmodule GetResponse do
    @moduledoc """
    [Plaid API /transactions/get response schema.](https://plaid.com/docs/api/transactions)
    """

    @behaviour Plaid.Castable

    alias Plaid.Accounts.Account
    alias Plaid.Castable
    alias Plaid.Item
    alias Plaid.Transactions.Transaction

    @type t :: %__MODULE__{
            accounts: [Account.t()],
            transactions: [Transaction.t()],
            item: Item.t(),
            total_transactions: integer(),
            request_id: String.t()
          }

    defstruct [
      :accounts,
      :transactions,
      :item,
      :total_transactions,
      :request_id
    ]

    @impl true
    def cast(generic_map) do
      %__MODULE__{
        accounts: Castable.cast_list(Account, generic_map["accounts"]),
        transactions: Castable.cast_list(Transaction, generic_map["transactions"]),
        item: Castable.cast(Item, generic_map["item"]),
        total_transactions: generic_map["total_transactions"],
        request_id: generic_map["request_id"]
      }
    end
  end

  @doc """
  Get information about transactions.

  Does a `POST /transactions/get` call which gives you high level account
  data along with transactions from all accounts contained in the
  `access_token`'s item.

  Params:
  * `access_token` - Token to fetch transactions for.
  * `start_date`   - Start of query for transactions.
  * `end_date`     - End of query for transactions.

  Options:
  * `:account_ids` - Specific account ids to fetch balances for.
  * `:count`       - Amount of transactions to pull.
  * `:offset`      - Offset to start pulling transactions.

  ## Example

      Transactions.get("access-sandbox-123xxx", "2019-10-10", "2019-10-20", client_id: "123", secret: "abc")
      {:ok, %Transactions.GetResponse{}}

  """
  @spec get(String.t(), String.t(), String.t(), options, Plaid.config()) ::
          {:ok, GetResponse.t()} | {:error, Plaid.Error.t()}
        when options: %{
               optional(:account_ids) => [String.t()],
               optional(:count) => integer(),
               optional(:offset) => integer()
             }
  def get(access_token, start_date, end_date, options \\ %{}, config) do
    options_payload = Map.take(options, [:account_ids, :count, :offset])

    payload =
      %{}
      |> Map.put(:access_token, access_token)
      |> Map.put(:start_date, start_date)
      |> Map.put(:end_date, end_date)
      |> Map.put(:options, options_payload)

    Plaid.Client.call(
      "/transactions/get",
      payload,
      Plaid.Transactions.GetResponse,
      config
    )
  end

  @doc """
  Manually refresh transactions.

  Does a `POST /transactions/refresh` call which kicks off a manual
  transactions extraction for all accounts contained in the `access_token`'s
  item.

  * `access_token` - Token to fetch transactions for.

  ## Examples

    Transactions.refresh("access-sandbox-123xxx", client_id: "123", secret: "abc")
    {:ok, %Plaid.SimpleResponse{}}

  """
  @spec refresh(String.t(), Plaid.config()) ::
          {:ok, Plaid.SimpleResponse.t()} | {:error, Plaid.Error.t()}
  def refresh(access_token, config) do
    Plaid.Client.call(
      "/transactions/refresh",
      %{access_token: access_token},
      Plaid.SimpleResponse,
      config
    )
  end
end
