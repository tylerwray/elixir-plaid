defmodule Plaid.Identity do
  @moduledoc """
  [Plaid Identity API](https://plaid.com/docs/api/products/#identity) calls and schema.
  """

  @type t :: %__MODULE__{
          addresses: list(Plaid.Identity.Address.t()),
          emails: list(Plaid.Identity.Email.t()),
          names: list(String.t()),
          phone_numbers: list(Plaid.Identity.PhoneNumber.t())
        }

  defstruct [:addresses, :emails, :names, :phone_numbers]

  @doc """
  Get information about all available accounts.

  Does a `POST /identity/get` call to retrieve account information,
  along with the `owners` info for each account associated with an access_token's item.

  Params:
  * `access_token` - Token to fetch identity for.

  Options:
  * `account_ids` - Specific account ids to fetch identity for.

  ## Examples

      get("access-sandbox-123xxx", client_id: "123", secret: "abc")
      {:ok, %Plaid.Accounts{}}

  """
  @spec get(String.t(), options, Plaid.config()) ::
          {:ok, Plaid.Accounts.t()} | {:error, Plaid.Error.t()}
        when options: %{optional(:account_ids) => list(String.t())}
  def get(access_token, options \\ %{}, config) do
    options_payload = Map.take(options, [:account_ids])

    payload =
      %{}
      |> Map.put(:access_token, access_token)
      |> Map.put(:options, options_payload)

    Plaid.Client.call("/identity/get", payload, Plaid.Accounts, config)
  end
end
