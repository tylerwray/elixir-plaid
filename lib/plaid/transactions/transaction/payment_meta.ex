defmodule Plaid.Transactions.Transaction.PaymentMeta do
  @moduledoc """
  [Plaid Transaction Payment-Meta schema.](https://plaid.com/docs/api/products/#transactions-get-response-payment-meta)
  """

  @behaviour Plaid.Castable

  alias Plaid.Castable

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

  @impl Castable
  def cast(generic_map) do
    %__MODULE__{
      reference_number: generic_map["reference_number"],
      ppd_id: generic_map["ppd_id"],
      payee: generic_map["payee"],
      by_order_of: generic_map["by_order_of"],
      payer: generic_map["payer"],
      payment_method: generic_map["payment_method"],
      payment_processor: generic_map["payment_processor"],
      reason: generic_map["reason"]
    }
  end
end
