defmodule Plaid.Identity.Address do
  @moduledoc """
  [Plaid Identity Address schema.](https://plaid.com/docs/api/products/#identity-get-response-addresses)
  """

  @type t :: %__MODULE__{
          data: Plaid.Identity.AddressData.t(),
          primary: boolean() | nil
        }

  defstruct [
    :data,
    :primary
  ]
end
