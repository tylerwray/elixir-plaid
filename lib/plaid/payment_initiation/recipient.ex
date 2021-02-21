defmodule Plaid.PaymentInitiation.Recipient do
  @moduledoc """
  [Plaid API recipient schema.](https://plaid.com/docs/api/products/#payment_initiation-recipient-list-response-recipients)
  """

  @behaviour Plaid.Castable

  alias Plaid.Castable
  alias Plaid.PaymentInitiation.{BACS, RecipientAddress}

  @type t :: %__MODULE__{
          recipient_id: String.t(),
          name: String.t(),
          address: RecipientAddress.t() | nil,
          iban: String.t() | nil,
          bacs: BACS.t() | nil
        }

  defstruct [
    :recipient_id,
    :name,
    :address,
    :iban,
    :bacs
  ]

  @impl true
  def cast(generic_map) do
    %__MODULE__{
      recipient_id: generic_map["recipient_id"],
      name: generic_map["name"],
      address: Castable.cast(RecipientAddress, generic_map["address"]),
      iban: generic_map["iban"],
      bacs: Castable.cast(BACS, generic_map["bacs"])
    }
  end
end
