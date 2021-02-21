defmodule Plaid.PaymentInitiation.ListRecipientsResponse do
  @moduledoc """
  [Plaid API /payment_initiation/recipient/list response schema.](https://plaid.com/docs/api/products/#payment_initiationrecipientlist)
  """

  @behaviour Plaid.Castable

  alias Plaid.Castable
  alias Plaid.PaymentInitiation.Recipient

  @type t :: %__MODULE__{
          recipients: [Recipient.t()],
          request_id: String.t()
        }

  defstruct [
    :recipients,
    :request_id
  ]

  @impl true
  def cast(generic_map) do
    %__MODULE__{
      recipients: Castable.cast_list(Recipient, generic_map["recipients"]),
      request_id: generic_map["request_id"]
    }
  end
end
