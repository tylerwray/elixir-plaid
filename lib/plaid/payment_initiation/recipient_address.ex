defmodule Plaid.PaymentInitiation.RecipientAddress do
  @moduledoc """
  [Plaid Payment Initiation Recipient Address schema.](https://plaid.com/docs/api/products/#payment_initiation-recipient-get-response-address)
  """

  @behaviour Plaid.Castable

  @type t :: %__MODULE__{
          city: String.t(),
          street: [String.t()],
          postal_code: String.t(),
          country: String.t() | nil
        }

  @derive Jason.Encoder
  defstruct [
    :city,
    :street,
    :postal_code,
    :country
  ]

  @impl true
  def cast(generic_map) do
    %__MODULE__{
      city: generic_map["city"],
      street: generic_map["street"],
      postal_code: generic_map["postal_code"],
      country: generic_map["country"]
    }
  end
end
