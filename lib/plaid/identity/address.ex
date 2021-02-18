defmodule Plaid.Identity.Address do
  @moduledoc """
  [Plaid Identity Address schema.](https://plaid.com/docs/api/products/#identity-get-response-addresses)
  """

  @behaviour Plaid.Castable

  alias Plaid.Address, as: AddressData
  alias Plaid.Castable

  @type t :: %__MODULE__{
          data: AddressData.t(),
          primary: boolean() | nil
        }

  defstruct [
    :data,
    :primary
  ]

  @impl Castable
  def cast(generic_map) do
    %__MODULE__{
      data: Castable.cast(AddressData, generic_map["data"]),
      primary: generic_map["primary"]
    }
  end
end
