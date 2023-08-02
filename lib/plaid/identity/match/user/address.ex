defmodule Plaid.Identity.Match.User.Address do
  @moduledoc """
  Struct for Plaid's [Identity Match User Address](https://plaid.com/docs/api/products/identity/#identity-match-request-user-address) object.
  """
  @behaviour Plaid.Castable

  @enforce_keys [:city, :region, :street, :postal_code, :country]

  @type t :: %__MODULE__{
          city: String.t(),
          region: String.t(),
          street: String.t(),
          postal_code: String.t(),
          country: String.t()
        }

  @derive Jason.Encoder
  defstruct [
    :city,
    :region,
    :street,
    :postal_code,
    :country
  ]

  @impl true
  def cast(map) do
    %__MODULE__{
      city: map["city"],
      region: map["region"],
      street: map["street"],
      postal_code: map["postal_code"],
      country: map["country"]
    }
  end
end
