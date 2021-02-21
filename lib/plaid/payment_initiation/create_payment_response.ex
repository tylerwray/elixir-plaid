defmodule Plaid.PaymentInitiation.CreatePaymentResponse do
  @moduledoc """
  [Plaid API /payment_initiation/payment/create response schema.](https://plaid.com/docs/api/products/#payment_initiationpaymentcreate)
  """

  @behaviour Plaid.Castable

  @type t :: %__MODULE__{
          payment_id: String.t(),
          status: String.t(),
          request_id: String.t()
        }

  defstruct [
    :payment_id,
    :status,
    :request_id
  ]

  @impl true
  def cast(generic_map) do
    %__MODULE__{
      payment_id: generic_map["payment_id"],
      status: generic_map["status"],
      request_id: generic_map["request_id"]
    }
  end
end
