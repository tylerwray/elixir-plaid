defmodule Plaid.Address do
  @moduledoc """
  [Plaid Address schema.](https://plaid.com/docs/api/products/#identity-get-response-data)
  """

  @behaviour Plaid.Castable

  alias Plaid.Castable

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

  @impl Castable
  def cast(generic_map) do
    %__MODULE__{
      city: generic_map["city"],
      region: generic_map["region"],
      street: generic_map["street"],
      postal_code: generic_map["postal_code"],
      country: generic_map["country"]
    }
  end
end
