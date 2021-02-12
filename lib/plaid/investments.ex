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
        when options: %{optional(:account_ids) => list(String.t())}
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
end
