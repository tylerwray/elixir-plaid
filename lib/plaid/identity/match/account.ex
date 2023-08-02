defmodule Plaid.Identity.Match.Account do
  @moduledoc """
  [Plaid Identity Match Account schema.](https://plaid.com/docs/api/products/identity/#identity-match-response-accounts).
  """
  @behaviour Plaid.Castable

  alias Plaid.Identity.Match.Account.{
    Address,
    EmailAddress,
    LegalName,
    PhoneNumber
  }

  alias Plaid.Castable

  @type t :: %__MODULE__{
          account_id: String.t(),
          balances: Plaid.Account.Balances.t() | nil,
          mask: String.t() | nil,
          name: String.t(),
          official_name: String.t() | nil,
          type: String.t(),
          subtype: String.t() | nil,
          verification_status: String.t(),
          persistent_account_id: String.t(),
          legal_name: LegalName.t() | nil,
          phone_number: PhoneNumber.t() | nil,
          email_address: EmailAddress.t() | nil,
          address: Address.t() | nil
        }

  defstruct [
    :account_id,
    :balances,
    :mask,
    :name,
    :verification_status,
    :persistent_account_id,
    :official_name,
    :type,
    :subtype,
    :legal_name,
    :phone_number,
    :email_address,
    :address
  ]

  @impl true
  def cast(generic_map) do
    %__MODULE__{
      account_id: generic_map["account_id"],
      balances: Castable.cast(Plaid.Account.Balances, generic_map["balances"]),
      mask: generic_map["mask"],
      name: generic_map["name"],
      official_name: generic_map["official_name"],
      type: generic_map["type"],
      subtype: generic_map["subtype"],
      verification_status: generic_map["verification_status"],
      persistent_account_id: generic_map["persistent_account_id"],
      legal_name: Castable.cast(LegalName, generic_map["legal_name"]),
      phone_number: Castable.cast(PhoneNumber, generic_map["phone_number"]),
      email_address: Castable.cast(EmailAddress, generic_map["email_address"]),
      address: Castable.cast(Address, generic_map["address"])
    }
  end
end
