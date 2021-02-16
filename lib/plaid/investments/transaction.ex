defmodule Plaid.Investments.Transaction do
  @moduledoc """
  [Plaid Investments Transaction schema](https://plaid.com/docs/api/products/#investments-transactions-get-response-investment-transactions)
  """

  @type t :: %__MODULE__{
          account_id: String.t(),
          amount: number(),
          cancel_transaction_id: String.t() | nil,
          date: String.t(),
          fees: number() | nil,
          investment_transaction_id: String.t(),
          iso_currency_code: String.t() | nil,
          name: String.t(),
          price: number(),
          quantity: number(),
          security_id: String.t() | nil,
          subtype: String.t(),
          type: String.t(),
          unofficial_currency_code: String.t() | nil
        }

  defstruct [
    :account_id,
    :amount,
    :cancel_transaction_id,
    :date,
    :fees,
    :investment_transaction_id,
    :iso_currency_code,
    :name,
    :price,
    :quantity,
    :security_id,
    :subtype,
    :type,
    :unofficial_currency_code
  ]
end
