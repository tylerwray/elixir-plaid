defmodule Plaid.PaymentInitiation.GetRecipientResponse do
  @moduledoc """
  [Plaid API /payment_initiation/recipient/get response schema.](https://plaid.com/docs/api/products/#payment_initiationrecipientget)
  """

  @behaviour Plaid.Castable

  alias Plaid.Castable
  alias Plaid.PaymentInitiation.{BACS, RecipientAddress}

  @type t :: %__MODULE__{
          recipient_id: String.t(),
          name: String.t(),
          address: RecipientAddress.t() | nil,
          iban: String.t() | nil,
          bacs: BACS.t() | nil,
          request_id: String.t()
        }

  defstruct [
    :recipient_id,
    :name,
    :address,
    :iban,
    :bacs,
    :request_id
  ]

  @impl true
  def cast(generic_map) do
    %__MODULE__{
      recipient_id: generic_map["recipient_id"],
      name: generic_map["name"],
      address: Castable.cast(RecipientAddress, generic_map["address"]),
      iban: generic_map["iban"],
      bacs: Castable.cast(BACS, generic_map["bacs"]),
      request_id: generic_map["request_id"]
    }
  end
end
