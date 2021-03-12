defmodule Plaid.LinkToken.PaymentInitiation do
  @moduledoc """
  [Plaid link token payment initiation argument.](https://plaid.com/docs/api/tokens/#link-token-create-request-payment-initiation)
  """

  @type t :: %__MODULE__{
          payment_id: String.t()
        }

  @enforce_keys [:payment_id]

  @derive Jason.Encoder
  defstruct [:payment_id]
end
