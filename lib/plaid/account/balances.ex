defmodule Plaid.Account.Balances do
  @moduledoc """
  [Plaid Balances schema.](https://plaid.com/docs/api/accounts)
  """

  @behaviour Plaid.Castable

  @type t :: %__MODULE__{
          available: number() | nil,
          current: number(),
          limit: number() | nil,
          iso_currency_code: String.t() | nil,
          unofficial_currency_code: String.t() | nil
        }

  defstruct [
    :available,
    :current,
    :limit,
    :iso_currency_code,
    :unofficial_currency_code
  ]

  @impl true
  def cast(generic_map) do
    %__MODULE__{
      available: generic_map["available"],
      current: generic_map["current"],
      limit: generic_map["limit"],
      iso_currency_code: generic_map["iso_currency_code"],
      unofficial_currency_code: generic_map["unofficial_currency_code"]
    }
  end
end
