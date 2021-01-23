defmodule Plaid.Accounts.Account do
  @moduledoc """
  Plaid Account schema.
  https://plaid.com/docs/api/accounts
  """

  @type t :: %__MODULE__{
          account_id: String.t(),
          balances: Plaid.Accounts.Account.Balances.t(),
          mask: String.t() | nil,
          name: String.t(),
          official_name: String.t() | nil,
          type: String.t(),
          subtype: String.t(),
          verification_status: String.t() | nil
        }

  defstruct [
    :account_id,
    :balances,
    :mask,
    :name,
    :official_name,
    :type,
    :subtype,
    :verification_status,
    :item
  ]
end
