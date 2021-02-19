defmodule Plaid.Investments.Transaction do
  @moduledoc """
  [Plaid Investments Transaction schema](https://plaid.com/docs/api/products/#investments-transactions-get-response-investment-transactions)
  """

  @behaviour Plaid.Castable

  alias Plaid.Castable

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

  @impl Castable
  def cast(generic_map) do
    %__MODULE__{
      account_id: generic_map["account_id"],
      amount: generic_map["amount"],
      cancel_transaction_id: generic_map["cancel_transaction_id"],
      date: generic_map["date"],
      fees: generic_map["fees"],
      investment_transaction_id: generic_map["investment_transaction_id"],
      iso_currency_code: generic_map["iso_currency_code"],
      name: generic_map["name"],
      price: generic_map["price"],
      quantity: generic_map["quantity"],
      security_id: generic_map["security_id"],
      subtype: generic_map["subtype"],
      type: generic_map["type"],
      unofficial_currency_code: generic_map["unofficial_currency_code"]
    }
  end
end
