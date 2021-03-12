defmodule Plaid.Account do
  @moduledoc """
  [Plaid Account schema.](https://plaid.com/docs/api/accounts)
  """

  @behaviour Plaid.Castable

  alias Plaid.Account.{Balances, HistoricalBalances}
  alias Plaid.Castable
  alias Plaid.Identity
  alias Plaid.Item
  alias Plaid.Transactions.Transaction

  @type t :: %__MODULE__{
          account_id: String.t(),
          balances: Balances.t(),
          days_available: non_neg_integer() | nil,
          historical_balances: [HistoricalBalances.t()] | nil,
          mask: String.t() | nil,
          name: String.t(),
          official_name: String.t() | nil,
          type: String.t(),
          subtype: String.t(),
          transactions: [Transaction.t()] | nil,
          verification_status: String.t() | nil,
          item: Plaid.Item.t(),
          owners: [Plaid.Identity.t()] | nil,
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

  @impl true
  def cast(generic_map) do
    %__MODULE__{
      account_id: generic_map["account_id"],
      balances: Castable.cast(Balances, generic_map["balances"]),
      days_available: generic_map["days_available"],
      historical_balances:
        Castable.cast_list(HistoricalBalances, generic_map["historical_balances"]),
      mask: generic_map["mask"],
      name: generic_map["name"],
      official_name: generic_map["official_name"],
      type: generic_map["type"],
      subtype: generic_map["subtype"],
      transactions: Castable.cast_list(Transaction, generic_map["transactions"]),
      verification_status: generic_map["verification_status"],
      item: Castable.cast(Item, generic_map["item"]),
      owners: Castable.cast_list(Identity, generic_map["owners"]),
      ownership_type: generic_map["ownership_type"]
    }
  end
end
