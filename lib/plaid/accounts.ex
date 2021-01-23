defmodule Plaid.Accounts do
  @moduledoc """
  Plaid Accounts API calls and schema.
  https://plaid.com/docs/api/accounts
  """

  @type t :: %__MODULE__{
          accounts: list(Plaid.Accounts.Account.t()),
          item: Plaid.Item.t(),
          request_id: String.t()
        }

  defstruct [:accounts, :item, :request_id]

  @typedoc """
  Options to pass to `get/3`.

  * `account_ids` - Specific account ids to fetch balances for.
  """
  @type get_options :: %{
          account_ids: list(String.t())
        }

  @doc """
  Get information about all available accounts.

  Does a `POST /accounts/get` call to retrieve high level account information
  associated with an access_token's item.

  * `access_token` - Token to fetch accounts for.

  Returns a struct with of the same module with accounts information.

  ## Examples

      get("access-sandbox-123xxx", client_id: "123", secret: "abc")
      {:ok, %Plaid.Accounts{}}

  """
  @spec get(String.t(), get_options(), Plaid.config()) :: {:ok, t()} | {:error, Plaid.Error.t()}
  def get(access_token, options \\ %{}, config) do
    Plaid.Client.call("/accounts/get", build_payload(access_token, options), __MODULE__, config)
  end

  @spec build_payload(String.t(), get_options()) :: map()
  defp build_payload(access_token, options) do
    options_payload = Map.take(options, [:account_ids])

    %{}
    |> Map.put(:access_token, access_token)
    |> Map.put(:options, options_payload)
  end
end
