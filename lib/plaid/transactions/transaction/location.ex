defmodule Plaid.Transactions.Transaction.Location do
  @moduledoc """
  [Plaid Transaction Location schema.](https://plaid.com/docs/api/products/#transactions-get-response-location0
  """

  @behaviour Plaid.Castable

  alias Plaid.Castable

  @type t :: %__MODULE__{
          address: String.t() | nil,
          city: String.t() | nil,
          region: String.t() | nil,
          postal_code: String.t() | nil,
          country: String.t() | nil,
          lat: number() | nil,
          lon: number() | nil,
          store_number: String.t() | nil
        }

  defstruct [
    :address,
    :city,
    :region,
    :postal_code,
    :country,
    :lat,
    :lon,
    :store_number
  ]

  @impl Castable
  def cast(generic_map) do
    %__MODULE__{
      address: generic_map["address"],
      city: generic_map["city"],
      region: generic_map["region"],
      postal_code: generic_map["postal_code"],
      country: generic_map["country"],
      lat: generic_map["lat"],
      lon: generic_map["lon"],
      store_number: generic_map["store_number"]
    }
  end
end
