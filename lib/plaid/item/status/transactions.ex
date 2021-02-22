defmodule Plaid.Item.Status.Transactions do
  @moduledoc """
  [Plaid item status transactions information.](https://plaid.com/docs/api/items/#item-get-response-transactions)
  """

  @behaviour Plaid.Castable

  @type t :: %__MODULE__{
          last_successful_update: String.t() | nil,
          last_failed_update: String.t() | nil
        }

  defstruct [
    :last_successful_update,
    :last_failed_update
  ]

  @impl true
  def cast(generic_map) do
    %__MODULE__{
      last_successful_update: generic_map["last_successful_update"],
      last_failed_update: generic_map["last_failed_update"]
    }
  end
end
