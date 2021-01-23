defmodule Plaid.Transactions.Transaction.PaymentMeta do
  @moduledoc """
  Plaid Transaction Payment-Meta schema.
  https://plaid.com/docs/api/products/#transactions-get-response-payment-meta
  """

  @type t :: %__MODULE__{
          reference_number: String.t() | nil,
          ppd_id: String.t() | nil,
          payee: String.t() | nil,
          by_order_of: String.t() | nil,
          payer: String.t() | nil,
          payment_method: String.t() | nil,
          payment_processor: String.t() | nil,
          reason: String.t() | nil
        }

  defstruct [
    :reference_number,
    :ppd_id,
    :payee,
    :by_order_of,
    :payer,
    :payment_method,
    :payment_processor,
    :reason
  ]
end
