defmodule Plaid.Identity do
  @moduledoc """
  [Plaid Identity API](https://plaid.com/docs/api/products/#identity) calls and schema.
  """

  @behaviour Plaid.Castable

  alias Plaid.Castable
  alias Plaid.Identity.{Address, Email, PhoneNumber}

  @type t :: %__MODULE__{
          addresses: list(Address.t()),
          emails: list(Email.t()),
          names: list(String.t()),
          phone_numbers: list(PhoneNumber.t())
        }

  defstruct [:addresses, :emails, :names, :phone_numbers]

  @impl Castable
  def cast(generic_map) do
    %__MODULE__{
      addresses: Castable.cast_list(Address, generic_map["addresses"]),
      emails: Castable.cast_list(Email, generic_map["emails"]),
      names: generic_map["names"],
      phone_numbers: Castable.cast_list(PhoneNumber, generic_map["phone_numbers"])
    }
  end

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
      {:ok, %Plaid.Accounts.GetResponse{}}

  """
  @spec get(String.t(), options, Plaid.config()) ::
          {:ok, Plaid.Accounts.GetResponse.t()} | {:error, Plaid.Error.t()}
        when options: %{optional(:account_ids) => list(String.t())}
  def get(access_token, options \\ %{}, config) do
    options_payload = Map.take(options, [:account_ids])

    payload =
      %{}
      |> Map.put(:access_token, access_token)
      |> Map.put(:options, options_payload)

    Plaid.Client.call("/identity/get", payload, Plaid.Identity.GetResponse, config)
  end
end
