defmodule Plaid.PaymentInitiation.CreateRecipientResponse do
  @moduledoc """
  [Plaid API /payment_initiation/recipient/create response schema.](https://plaid.com/docs/api/products/#payment_initiationrecipientcreate)
  """

  @behaviour Plaid.Castable

  @type t :: %__MODULE__{
          recipient_id: String.t(),
          request_id: String.t()
        }

  defstruct [
    :recipient_id,
    :request_id
  ]

  @impl true
  def cast(generic_map) do
    %__MODULE__{
      recipient_id: generic_map["recipient_id"],
      request_id: generic_map["request_id"]
    }
  end
end
