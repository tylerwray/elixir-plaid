defmodule Plaid.Transactions.Transaction.Location do
  @moduledoc """
  [Plaid Transaction Location schema.](https://plaid.com/docs/api/products/#transactions-get-response-location0
  """

  @type t :: %__MODULE__{
          address: String.t() | nil,
          city: String.t() | nil,
          region: String.t() | nil,
          postal_code: String.t() | nil,
          country: String.t() | nil,
          lat: float() | nil,
          lon: float() | nil,
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
end
