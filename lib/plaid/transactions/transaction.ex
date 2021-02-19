defmodule Plaid.Transactions.Transaction do
  @moduledoc """
  [Plaid Transaction schema.](https://plaid.com/docs/api/transactions)
  """

  @behaviour Plaid.Castable

  alias Plaid.Castable
  alias Plaid.Transactions.Transaction.{Location, PaymentMeta}

  @type t :: %__MODULE__{
          account_id: String.t(),
          amount: number(),
          iso_currency_code: String.t() | nil,
          unofficial_currency_code: String.t() | nil,
          category: [String.t()] | nil,
          category_id: String.t(),
          date: String.t(),
          authorized_date: String.t() | nil,
          location: Location.t(),
          name: String.t(),
          merchant_name: String.t() | nil,
          payment_meta: PaymentMeta.t(),
          payment_channel: String.t(),
          pending: boolean(),
          pending_transaction_id: String.t() | nil,
          account_owner: String.t() | nil,
          transaction_id: String.t(),
          transaction_code: String.t() | nil,
          transaction_type: String.t(),
          date_transacted: String.t() | nil,
          original_description: String.t() | nil
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
    :transaction_type,
    :date_transacted,
    :original_description
  ]

  @impl true
  def cast(generic_map) do
    %__MODULE__{
      account_id: generic_map["account_id"],
      amount: generic_map["amount"],
      iso_currency_code: generic_map["iso_currency_code"],
      unofficial_currency_code: generic_map["unofficial_currency_code"],
      category: generic_map["category"],
      category_id: generic_map["category_id"],
      date: generic_map["date"],
      authorized_date: generic_map["authorized_date"],
      location: Castable.cast(Location, generic_map["location"]),
      name: generic_map["name"],
      merchant_name: generic_map["merchant_name"],
      payment_meta: Castable.cast(PaymentMeta, generic_map["payment_meta"]),
      payment_channel: generic_map["payment_channel"],
      pending: generic_map["pending"],
      pending_transaction_id: generic_map["pending_transaction_id"],
      account_owner: generic_map["account_owner"],
      transaction_id: generic_map["transaction_id"],
      transaction_code: generic_map["transaction_code"],
      transaction_type: generic_map["transaction_type"],
      date_transacted: generic_map["date_transacted"],
      original_description: generic_map["original_description"]
    }
  end
end
