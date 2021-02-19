defmodule Plaid.Auth.GetResponse do
  @moduledoc """
  [Plaid API /auth/get response](https://plaid.com/docs/api/products/#auth).
  """

  @behaviour Plaid.Castable

  alias Plaid.Accounts.Account
  alias Plaid.Auth.Numbers
  alias Plaid.Castable
  alias Plaid.Item

  @type t :: %__MODULE__{
          accounts: [Account.t()],
          numbers: Numbers.t(),
          item: Item.t(),
          request_id: String.t()
        }

  defstruct [
    :accounts,
    :numbers,
    :item,
    :request_id
  ]

  @impl true
  def cast(generic_map) do
    %__MODULE__{
      accounts: Castable.cast_list(Account, generic_map["accounts"]),
      numbers: Castable.cast(Numbers, generic_map["numbers"]),
      item: Castable.cast(Item, generic_map["item"]),
      request_id: generic_map["request_id"]
    }
  end
end
