defmodule Plaid.PaymentInitiation.Payment do
  @moduledoc """
  [Plaid API payment initiation payment schema.](https://plaid.com/docs/api/products/#payment_initiation-recipient-list-response-recipients)
  """

  @behaviour Plaid.Castable

  alias Plaid.Castable
  alias Plaid.PaymentInitiation.{Amount, Schedule}

  @type t :: %__MODULE__{
          adjusted_reference: String.t(),
          amount: Amount.t() | nil,
          last_status_update: String.t(),
          payment_id: String.t(),
          recipient_id: String.t(),
          reference: String.t(),
          schedule: Schedule.t(),
          status: String.t() | nil
        }

  defstruct [
    :adjusted_reference,
    :amount,
    :last_status_update,
    :payment_id,
    :recipient_id,
    :reference,
    :schedule,
    :status
  ]

  @impl true
  def cast(generic_map) do
    %__MODULE__{
      adjusted_reference: generic_map["adjusted_reference"],
      amount: Castable.cast(Amount, generic_map["amount"]),
      last_status_update: generic_map["last_status_update"],
      payment_id: generic_map["payment_id"],
      recipient_id: generic_map["recipient_id"],
      reference: generic_map["reference"],
      schedule: Castable.cast(Schedule, generic_map["schedule"]),
      status: generic_map["status"]
    }
  end
end
