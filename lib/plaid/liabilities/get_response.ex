defmodule Plaid.Liabilities.GetResponse do
  @moduledoc """
  [Plaid /liabilities/get API Response Schema.](https://plaid.com/docs/api/products/#liabilitiesget)
  """

  @behaviour Plaid.Castable

  alias Plaid.Accounts.Account
  alias Plaid.Castable
  alias Plaid.Item
  alias Plaid.Liabilities

  @type t :: %__MODULE__{
          accounts: [Account.t()],
          item: Item.t(),
          liabilities: Liabilities.t(),
          request_id: String.t()
        }

  defstruct [
    :accounts,
    :item,
    :liabilities,
    :request_id
  ]

  @impl true
  def cast(generic_map) do
    %__MODULE__{
      accounts: Castable.cast_list(Account, generic_map["accounts"]),
      item: Castable.cast(Item, generic_map["item"]),
      liabilities: Castable.cast(Liabilities, generic_map["liabilities"]),
      request_id: generic_map["request_id"]
    }
  end
end
