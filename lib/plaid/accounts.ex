defmodule Plaid.Accounts do
  @moduledoc """
  [Plaid Accounts API](https://plaid.com/docs/api/accounts) calls and schema.
  """

  @type t :: %__MODULE__{
          accounts: list(Plaid.Accounts.Account.t()),
          item: Plaid.Item.t(),
          request_id: String.t()
        }

  defstruct [:accounts, :item, :request_id]

  @doc """
  Get information about all available accounts.

  Does a `POST /accounts/get` call to retrieve high level account information
  associated with an access_token's item.

  Params:
  * `access_token` - Token to fetch accounts for.

  Options:
  * `account_ids` - Specific account ids to fetch balances for.

  Returns a struct of the same module with accounts information.

  ## Examples

      get("access-sandbox-123xxx", client_id: "123", secret: "abc")
      {:ok, %Plaid.Accounts{}}

  """
  @spec get(String.t(), options, Plaid.config()) :: {:ok, t()} | {:error, Plaid.Error.t()}
        when options: %{optional(:account_ids) => list(String.t())}
  def get(access_token, options \\ %{}, config) do
    options_payload = Map.take(options, [:account_ids])

    payload =
      %{}
      |> Map.put(:access_token, access_token)
      |> Map.put(:options, options_payload)

    Plaid.Client.call("/accounts/get", payload, __MODULE__, config)
  end
end
