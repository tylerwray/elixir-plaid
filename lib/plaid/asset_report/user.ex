defmodule Plaid.AssetReport.User do
  @moduledoc """
  [Plaid Asset Report User schema.](https://plaid.com/docs/api/products/#asset_report-create-request-user)
  """

  @behaviour Plaid.Castable

  alias Plaid.Castable

  @type t :: %__MODULE__{
          client_user_id: String.t(),
          first_name: String.t(),
          middle_name: String.t(),
          last_name: String.t(),
          ssn: String.t(),
          phone_number: String.t(),
          email: String.t()
        }

  @derive Jason.Encoder
  defstruct [
    :client_user_id,
    :first_name,
    :middle_name,
    :last_name,
    :ssn,
    :phone_number,
    :email
  ]

  @impl Castable
  def cast(generic_map) do
    %__MODULE__{
      client_user_id: generic_map["client_user_id"],
      first_name: generic_map["first_name"],
      middle_name: generic_map["middle_name"],
      last_name: generic_map["last_name"],
      ssn: generic_map["ssn"],
      phone_number: generic_map["phone_number"],
      email: generic_map["email"]
    }
  end
end
