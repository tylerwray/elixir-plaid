defmodule Plaid.PaymentInitiation.ListPaymentsResponse do
  @moduledoc """
  [Plaid API /payment_initiation/payment/list response schema.](https://plaid.com/docs/api/products/#payment_initiationpaymentlist)
  """

  @behaviour Plaid.Castable

  alias Plaid.Castable
  alias Plaid.PaymentInitiation.Payment

  @type t :: %__MODULE__{
          payments: [Payment.t()],
          next_cursor: String.t(),
          request_id: String.t()
        }

  defstruct [
    :payments,
    :next_cursor,
    :request_id
  ]

  @impl true
  def cast(generic_map) do
    %__MODULE__{
      payments: Castable.cast_list(Payment, generic_map["payments"]),
      next_cursor: generic_map["next_cursor"],
      request_id: generic_map["request_id"]
    }
  end
end
