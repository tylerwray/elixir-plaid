defmodule Plaid.Address do
  @moduledoc """
  [Plaid Address schema.](https://plaid.com/docs/api/products/#identity-get-response-data)
  """

  @type t :: %__MODULE__{
          city: String.t() | nil,
          region: String.t() | nil,
          street: String.t() | nil,
          postal_code: String.t() | nil,
          country: String.t() | nil
        }

  defstruct [
    :city,
    :region,
    :street,
    :postal_code,
    :country
  ]
end
