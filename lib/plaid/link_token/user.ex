defmodule Plaid.LinkToken.User do
  @moduledoc """
  [Plaid link token user argument.](https://plaid.com/docs/api/tokens/#link-token-create-request-user)
  """

  @type t :: %__MODULE__{
          client_user_id: String.t(),
          legal_name: String.t() | nil,
          phone_number: String.t() | nil,
          phone_number_verified_time: String.t() | nil,
          email_address: String.t() | nil,
          email_address_verified_time: String.t() | nil,
          ssn: String.t() | nil,
          date_of_birth: String.t() | nil
        }

  @enforce_keys [:client_user_id]

  @derive Jason.Encoder
  defstruct [
    :client_user_id,
    :legal_name,
    :phone_number,
    :phone_number_verified_time,
    :email_address,
    :email_address_verified_time,
    :ssn,
    :date_of_birth
  ]
end
