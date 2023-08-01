defmodule Plaid.Identity.Match.Account do
  @behaviour Plaid.Castable

  alias Plaid.Identity.Match
  alias Plaid.Castable

  defstruct [
    :account_id,
    :balances,
    :mask,
    :name,
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
      legal_name: Castable.cast(Match.LegalName, generic_map["legal_name"]),
      phone_number: Castable.cast(Match.Score, generic_map["phone_number"]),
      email_address: Castable.cast(Match.Score, generic_map["email_address"]),
      address: Castable.cast(Match.Address, generic_map["address"])
    }
  end
end
