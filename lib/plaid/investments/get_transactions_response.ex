defmodule Plaid.Investments.GetTransactionsResponse do
  @moduledoc """
  [Plaid Investments Get Transactions Response schema](https://plaid.com/docs/api/products/#investmentstransactionsget)
  """

  @behaviour Plaid.Castable

  alias Plaid.Castable
  alias Plaid.Accounts.Account
  alias Plaid.Item
  alias Plaid.Investments.{Security, Transaction}

  @type t :: %__MODULE__{
          item: Item.t(),
          accounts: [Account.t()],
          securities: [Security.t()],
          investment_transactions: [Transaction.t()],
          total_investment_transactions: integer(),
          request_id: String.t()
        }

  defstruct [
    :item,
    :accounts,
    :securities,
    :investment_transactions,
    :total_investment_transactions,
    :request_id
  ]

  @impl true
  def cast(generic_map) do
    %__MODULE__{
      item: Castable.cast(Item, generic_map["item"]),
      accounts: Castable.cast_list(Account, generic_map["accounts"]),
      securities: Castable.cast_list(Security, generic_map["securities"]),
      investment_transactions:
        Castable.cast_list(Transaction, generic_map["investment_transactions"]),
      total_investment_transactions: generic_map["total_investment_transactions"],
      request_id: generic_map["request_id"]
    }
  end
end
