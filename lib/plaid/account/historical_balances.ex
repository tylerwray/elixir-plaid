defmodule Plaid.Account.HistoricalBalances do
  @moduledoc """
  [Plaid Account Historical Balances schema](https://plaid.com/docs/api/products/#asset_report-get-response-historical-balances)

  Only used when retrieving Asset Report's.
  """

  @behaviour Plaid.Castable

  @type t :: %__MODULE__{
          current: number(),
          date: String.t(),
          iso_currency_code: String.t() | nil,
          unofficial_currency_code: String.t() | nil
        }

  defstruct [
    :current,
    :date,
    :iso_currency_code,
    :unofficial_currency_code
  ]

  @impl true
  def cast(generic_map) do
    %__MODULE__{
      current: generic_map["current"],
      date: generic_map["date"],
      iso_currency_code: generic_map["iso_currency_code"],
      unofficial_currency_code: generic_map["unofficial_currency_code"]
    }
  end
end
