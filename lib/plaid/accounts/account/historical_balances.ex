defmodule Plaid.Accounts.Account.HistoricalBalances do
  @moduledoc """
  [Plaid Account Historical Balances schema](https://plaid.com/docs/api/products/#asset_report-get-response-historical-balances)

  Only used when retrieving Asset Report's.
  """

  @type t :: %__MODULE__{
          current: float(),
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
end
