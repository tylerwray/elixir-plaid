defmodule Plaid.Transactions.Transaction do
  @moduledoc """
  [Plaid Transaction schema.](https://plaid.com/docs/api/transactions)
  """

  @type t :: %__MODULE__{
          account_id: String.t(),
          amount: float(),
          iso_currency_code: String.t() | nil,
          unofficial_currency_code: String.t() | nil,
          category: list(String.t()) | nil,
          category_id: String.t(),
          # TODO: Make all dates their own type? Plaid.date()?
          date: String.t(),
          authorized_date: String.t() | nil,
          location: Plaid.Transactions.Transaction.Location.t(),
          name: String.t(),
          merchant_name: String.t() | nil,
          payment_meta: Plaid.Transactions.Transaction.PaymentMeta.t(),
          payment_channel: String.t(),
          pending: boolean(),
          pending_transaction_id: String.t() | nil,
          account_owner: String.t() | nil,
          transaction_id: String.t(),
          transaction_code: String.t() | nil,
          transaction_type: String.t()
        }

  defstruct [
    :account_id,
    :amount,
    :iso_currency_code,
    :unofficial_currency_code,
    :category,
    :category_id,
    :date,
    :authorized_date,
    :location,
    :name,
    :merchant_name,
    :payment_meta,
    :payment_channel,
    :pending,
    :pending_transaction_id,
    :account_owner,
    :transaction_id,
    :transaction_code,
    :transaction_type
  ]
end
