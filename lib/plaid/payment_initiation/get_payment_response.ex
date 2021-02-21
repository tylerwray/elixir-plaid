defmodule Plaid.PaymentInitiation.GetPaymentResponse do
  @moduledoc """
  [Plaid API /payment_initiation/payment/get response schema.](https://plaid.com/docs/api/products/#payment_initiationpaymentget)
  """

  @behaviour Plaid.Castable

  alias Plaid.Castable
  alias Plaid.PaymentInitiation.{Amount, Schedule}

  @type t :: %__MODULE__{
          payment_id: String.t(),
          payment_token: String.t(),
          amount: Amount.t(),
          status: String.t(),
          recipient_id: String.t(),
          reference: String.t(),
          last_status_update: String.t(),
          schedule: Schedule.t() | nil,
          adjusted_reference: String.t() | nil,
          payment_expiration_time: String.t() | nil,
          request_id: String.t()
        }

  defstruct [
    :payment_id,
    :payment_token,
    :amount,
    :status,
    :recipient_id,
    :reference,
    :last_status_update,
    :schedule,
    :adjusted_reference,
    :payment_expiration_time,
    :request_id
  ]

  @impl true
  def cast(generic_map) do
    %__MODULE__{
      payment_id: generic_map["payment_id"],
      payment_token: generic_map["payment_token"],
      amount: Castable.cast(Amount, generic_map["amount"]),
      status: generic_map["status"],
      recipient_id: generic_map["recipient_id"],
      reference: generic_map["reference"],
      last_status_update: generic_map["last_status_update"],
      schedule: Castable.cast(Schedule, generic_map["schedule"]),
      adjusted_reference: generic_map["adjust_reference"],
      payment_expiration_time: generic_map["payment_expiration_time"],
      request_id: generic_map["request_id"]
    }
  end
end
