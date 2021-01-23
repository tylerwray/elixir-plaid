defmodule Plaid.Transactions do
  @moduledoc """
  [Plaid Transactions API](https://plaid.com/docs/api/transactions) calls and schema.
  """

  @type t :: %__MODULE__{
          accounts: list(Plaid.Accounts.Account.t()),
          transactions: list(Plaid.Transactions.Transaction.t()),
          item: Plaid.Item.t(),
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
  * `account_ids` - Specific account ids to fetch balances for.
  * `count`       - Amount of transactions to pull.
  * `offset`      - Offset to start pulling transactions.

  Returns a struct of the same module with transactions information.

  ## Example

      get("access-sandbox-123xxx", "2019-10-10", "2019-10-20", client_id: "123", secret: "abc")
      {:ok, %Plaid.Transactions{}}

  """
  @spec get(String.t(), String.t(), String.t(), options, Plaid.config()) ::
          {:ok, t()} | {:error, Plaid.Error.t()}
        when options: %{
               optional(:account_ids) => list(String.t()),
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
      __MODULE__,
      config
    )
  end

  @doc """
  Manually refresh transactions.

  Does a `POST /transactions/refresh` call which kicks off a manual
  transactions extraction for all accounts contained in the `access_token`'s
  item.

  * `access_token` - Token to fetch transactions for.

  Returns a SimpleResponse struct.

  ## Examples

    refresh("access-sandbox-123xxx", client_id: "123", secret: "abc")
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
