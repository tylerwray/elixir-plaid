defmodule Plaid.PaymentInitiation.Amount do
  @moduledoc """
  [Plaid payment initiation payment amount.](https://plaid.com/docs/api/products/#payment_initiation-payment-create-request-amount)
  """

  @behaviour Plaid.Castable

  @type t :: %__MODULE__{
          currency: number(),
          value: String.t()
        }

  @enforce_keys [:currency, :value]

  @derive Jason.Encoder
  defstruct [
    :currency,
    :value
  ]

  @impl true
  def cast(generic_map) do
    %__MODULE__{
      currency: generic_map["currency"],
      value: generic_map["value"]
    }
  end
end
