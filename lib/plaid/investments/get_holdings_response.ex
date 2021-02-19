defmodule Plaid.Investments.GetHoldingsResponse do
  @moduledoc """
  [Plaid Investments Get Holdings Response schema](https://plaid.com/docs/api/products/#investmentsholdingsget)
  """

  @behaviour Plaid.Castable

  alias Plaid.Castable
  alias Plaid.Accounts.Account
  alias Plaid.Investments.{Holding, Security}
  alias Plaid.Item

  @type t :: %__MODULE__{
          accounts: list(Account.t()),
          holdings: list(Holding.t()),
          securities: list(Security.t()),
          item: Item.t(),
          request_id: String.t()
        }

  defstruct [
    :accounts,
    :holdings,
    :securities,
    :item,
    :request_id
  ]

  @impl Castable
  def cast(generic_map) do
    %__MODULE__{
      accounts: Castable.cast_list(Account, generic_map["accounts"]),
      holdings: Castable.cast_list(Holding, generic_map["holdings"]),
      securities: Castable.cast_list(Security, generic_map["securities"]),
      item: Castable.cast(Item, generic_map["item"]),
      request_id: generic_map["request_id"]
    }
  end
end
