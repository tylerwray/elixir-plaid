defmodule Plaid.Transactions.GetResponse do
  @moduledoc """
  [Plaid API /transactions/get response schema.](https://plaid.com/docs/api/transactions)
  """

  @behaviour Plaid.Castable

  alias Plaid.Castable
  alias Plaid.Accounts.Account
  alias Plaid.Transactions.Transaction
  alias Plaid.Item

  @type t :: %__MODULE__{
          accounts: [Account.t()],
          transactions: [Transaction.t()],
          item: Item.t(),
          total_transactions: integer(),
          request_id: String.t()
        }

  defstruct [
    :accounts,
    :transactions,
    :item,
    :total_transactions,
    :request_id
  ]

  @impl true
  def cast(generic_map) do
    %__MODULE__{
      accounts: Castable.cast_list(Account, generic_map["accounts"]),
      transactions: Castable.cast_list(Transaction, generic_map["transactions"]),
      item: Castable.cast(Item, generic_map["item"]),
      total_transactions: generic_map["total_transactions"],
      request_id: generic_map["request_id"]
    }
  end
end
