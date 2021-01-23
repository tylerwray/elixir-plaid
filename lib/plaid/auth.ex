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
