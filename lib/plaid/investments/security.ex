defmodule Plaid.Investments.Security do
  @moduledoc """
  [Plaid Investments Security schema](https://plaid.com/docs/api/products/#investments-holdings-get-response-securities)
  """

  @type t :: %__MODULE__{
          close_price: float() | nil,
          close_price_as_of: String.t() | nil,
          cusip: String.t() | nil,
          institution_id: String.t() | nil,
          institution_security_id: String.t() | nil,
          is_cash_equivalent: boolean(),
          isin: String.t() | nil,
          iso_currency_code: String.t() | nil,
          name: String.t() | nil,
          proxy_security_id: String.t() | nil,
          security_id: String.t(),
          sedol: String.t() | nil,
          ticker_symbol: String.t() | nil,
          type: String.t(),
          unofficial_currency_code: String.t() | nil
        }

  defstruct [
    :close_price,
    :close_price_as_of,
    :cusip,
    :institution_id,
    :institution_security_id,
    :is_cash_equivalent,
    :isin,
    :iso_currency_code,
    :name,
    :proxy_security_id,
    :security_id,
    :sedol,
    :ticker_symbol,
    :type,
    :unofficial_currency_code
  ]
end
