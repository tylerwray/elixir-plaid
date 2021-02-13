defmodule Plaid.Investments.GetTransactionsResponse do
  @moduledoc """
  [Plaid Investments Get Transactions Response schema](https://plaid.com/docs/api/products/#investmentstransactionsget)
  """

  @type t :: %__MODULE__{
          item: Plaid.Item.t(),
          accounts: list(Plaid.Accounts.Account.t()),
          securities: list(Plaid.Investments.Security.t()),
          investment_transactions: list(Plaid.Investments.Transaction.t()),
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
end
