defmodule Plaid.Identity.Match.User do
  @moduledoc """
  Struct for Plaid's [Identity Match User](https://plaid.com/docs/api/products/identity/#identity-match-request-user) object.
  """
  alias __MODULE__

  @type t :: %__MODULE__{
          legal_name: String.t(),
          phone_number: String.t(),
          email_address: String.t(),
          address: User.Address.t()
        }

  @enforce_keys [:address]

  @derive Jason.Encoder
  defstruct [
    :legal_name,
    :phone_number,
    :email_address,
    :address
  ]
end
