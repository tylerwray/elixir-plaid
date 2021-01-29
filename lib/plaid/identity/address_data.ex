defmodule Plaid.Identity.AddressData do
  @moduledoc """
  [Plaid Identity Address data schema.](https://plaid.com/docs/api/products/#identity-get-response-data)
  """

  @type t :: %__MODULE__{
          city: String.t(),
          region: String.t() | nil,
          street: String.t(),
          postal_code: String.t() | nil,
          country: String.t()
        }

  defstruct [
    :city,
    :region,
    :street,
    :postal_code,
    :country
  ]
end
