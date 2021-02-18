defmodule Plaid.Accounts.GetResponse do
  @moduledoc """
  [Plaid Accounts API](https://plaid.com/docs/api/accounts) calls and schema.
  """

  @behaviour Plaid.Castable

  alias Plaid.Accounts.Account
  alias Plaid.Castable
  alias Plaid.Item

  @type t :: %__MODULE__{
          accounts: list(Account.t()),
          item: Item.t(),
          request_id: String.t()
        }

  defstruct [:accounts, :item, :request_id]

  @impl Castable
  def cast(generic_map) do
    %__MODULE__{
      accounts: Castable.cast_list(Account, generic_map["accounts"]),
      item: Castable.cast(Item, generic_map["item"]),
      request_id: generic_map["request_id"]
    }
  end
end
