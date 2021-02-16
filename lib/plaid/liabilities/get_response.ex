defmodule Plaid.Liabilities.GetResponse do
  @moduledoc """
  [Plaid /liabilities/get API Response Schema.](https://plaid.com/docs/api/products/#liabilitiesget)
  """
  @type t :: %__MODULE__{
          accounts: list(Plaid.Accounts.Account.t()),
          item: Plaid.Item.t(),
          liabilities: Plaid.Liabilities.t(),
          request_id: String.t()
        }

  defstruct [
    :accounts,
    :item,
    :liabilities,
    :request_id
  ]
end
