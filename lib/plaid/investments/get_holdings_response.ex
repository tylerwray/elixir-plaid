defmodule Plaid.Investments.GetHoldingsResponse do
  @moduledoc """
  [Plaid Investments Get Holdings Response schema](https://plaid.com/docs/api/products/#investmentsholdingsget)
  """

  @type t :: %__MODULE__{
          accounts: list(Plaid.Accounts.Account.t()),
          holdings: list(Plaid.Investments.Holding.t()),
          securities: list(Plaid.Investments.Security.t()),
          item: Plaid.Item.t(),
          request_id: String.t()
        }

  defstruct [
    :accounts,
    :holdings,
    :securities,
    :item,
    :request_id
  ]
end
