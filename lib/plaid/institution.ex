defmodule Plaid.Institution do
  @moduledoc """
  [Plaid Institution schema](https://plaid.com/docs/api/institutions/#institutions-get-response-institutions)
  """

  @behaviour Plaid.Castable

  alias Plaid.Castable
  alias Plaid.Institution.Status

  @type t :: %__MODULE__{
          country_codes: [String.t()],
          institution_id: String.t(),
          logo: String.t() | nil,
          name: String.t(),
          oauth: boolean(),
          primary_color: String.t() | nil,
          products: [String.t()],
          routing_numbers: [String.t()] | nil,
          status: Status.t(),
          url: String.t() | nil
        }

  defstruct [
    :country_codes,
    :institution_id,
    :logo,
    :name,
    :oauth,
    :primary_color,
    :products,
    :routing_numbers,
    :status,
    :url
  ]

  @impl true
  def cast(generic_map) do
    %__MODULE__{
      country_codes: generic_map["country_codes"],
      institution_id: generic_map["institution_id"],
      logo: generic_map["logo"],
      name: generic_map["name"],
      oauth: generic_map["oauth"],
      primary_color: generic_map["primary_color"],
      products: generic_map["products"],
      routing_numbers: generic_map["routing_numbers"],
      status: Castable.cast(Status, generic_map["status"]),
      url: generic_map["url"]
    }
  end
end
