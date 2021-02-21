defmodule Plaid.PaymentInitiation.Schedule do
  @moduledoc """
  [Plaid payment initiation payment schedule.](https://plaid.com/docs/api/products/#payment_initiation-payment-create-request-schedule)
  """

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
end
