defmodule Plaid.Accounts.Account do
  @moduledoc """
  [Plaid Account schema.](https://plaid.com/docs/api/accounts)
  """

  @type t :: %__MODULE__{
          account_id: String.t(),
          balances: Plaid.Accounts.Account.Balances.t(),
          days_available: non_neg_integer() | nil,
          historical_balances: list(Plaid.Accounts.Account.HistoricalBalance.t()) | nil,
          mask: String.t() | nil,
          name: String.t(),
          official_name: String.t() | nil,
          type: String.t(),
          subtype: String.t(),
          transactions: list(Plaid.Transactions.Transaction.t()) | nil,
          verification_status: String.t() | nil,
          item: Plaid.Item.t(),
          owners: list(Plaid.Identity.t()) | nil,
          ownership_type: String.t() | nil
        }

  defstruct [
    :account_id,
    :balances,
    :days_available,
    :historical_balances,
    :mask,
    :name,
    :official_name,
    :type,
    :subtype,
    :transactions,
    :verification_status,
    :item,
    :owners,
    :ownership_type
  ]
end
