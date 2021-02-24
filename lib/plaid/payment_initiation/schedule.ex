defmodule Plaid.PaymentInitiation.Schedule do
  @moduledoc """
  [Plaid payment initiation payment schedule.](https://plaid.com/docs/api/products/#payment_initiation-payment-create-request-schedule)
  """

  @behaviour Plaid.Castable

  @type t :: %__MODULE__{
          interval: String.t(),
          interval_execution_day: number(),
          start_date: String.t(),
          end_date: String.t()
        }

  @enforce_keys [:interval, :interval_execution_day, :start_date]

  @derive Jason.Encoder
  defstruct [
    :interval,
    :interval_execution_day,
    :start_date,
    :end_date
  ]

  @impl true
  def cast(generic_map) do
    %__MODULE__{
      interval: generic_map["interval"],
      interval_execution_day: generic_map["interval_execution_day"],
      start_date: generic_map["start_date"],
      end_date: generic_map["end_date"]
    }
  end
end
