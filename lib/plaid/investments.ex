defmodule Plaid.Investments do
  @moduledoc """
  [Plaid Investments APIs](https://plaid.com/docs/api/products/#investments)
  """

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
      {:ok, %Plaid.Investments.GetHoldingsResponse{}}

  """
  @spec get_holdings(String.t(), options, Plaid.Config.t()) ::
          {:ok, Plaid.Investments.GetHoldingsResponse.t()} | {:error, Plaid.Error.t()}
        when options: %{optional(:account_ids) => [String.t()]}
  def get_holdings(access_token, options \\ %{}, config) do
    options_payload = Map.take(options, [:account_ids])

    payload = %{access_token: access_token, options: options_payload}

    Plaid.Client.call(
      "/investments/holdings/get",
      payload,
      Plaid.Investments.GetHoldingsResponse,
      config
    )
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
      {:ok, %Plaid.Investments.GetTransactionsResponse{}}

  """
  @spec get_transactions(String.t(), String.t(), String.t(), options, Plaid.Config.t()) ::
          {:ok, Plaid.Investments.GetTransactionsResponse.t()} | {:error, Plaid.Error.t()}
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
      Plaid.Investments.GetTransactionsResponse,
      config
    )
  end
end
