defmodule Plaid.Auth do
  @moduledoc """
  [Plaid Auth API](https://plaid.com/docs/api/products/#auth) calls and schema.
  """

  @type t :: %__MODULE__{
          accounts: list(Plaid.Accounts.Account.t()),
          numbers: Plaid.Auth.Numbers.t(),
          item: Plaid.Item.t(),
          request_id: String.t()
        }

  defstruct [
    :accounts,
    :numbers,
    :item,
    :request_id
  ]

  @doc """
  Get information about account and routing numbers for
  checking and savings accounts.

  Does a POST /auth/get call which returns high level account information
  along with account and routing numbers for checking and savings
  accounts.

  Params:
  * `access_token` - Token to fetch accounts for.

  Options:
  * `account_ids` - Specific account ids to fetch balances for.

  Returns a struct of the same module with auth information.

  ## Examples

      get("access-sandbox-123xxx", client_id: "123", secret: "abc")
      {:ok, %Plaid.Auth{}}

  """
  @spec get(String.t(), options, Plaid.config()) ::
          {:ok, t()} | {:error, Plaid.Error.t()}
        when options: %{optional(:account_ids) => list(String.t())}
  def get(access_token, options \\ %{}, config) do
    options_payload = Map.take(options, [:account_ids])

    payload =
      %{}
      |> Map.put(:access_token, access_token)
      |> Map.put(:options, options_payload)

    Plaid.Client.call(
      "/auth/get",
      payload,
      __MODULE__,
      config
    )
  end
end
