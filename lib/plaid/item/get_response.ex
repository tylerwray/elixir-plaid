defmodule Plaid.Item.GetResponse do
  @moduledoc """
  [Plaid API /item/get response schema.](https://plaid.com/docs/api/items/#itemget)
  """

  @behaviour Plaid.Castable

  alias Plaid.Castable
  alias Plaid.Item
  alias Plaid.Item.Status

  @type t :: %__MODULE__{
          item: Item.t(),
          status: Status.t() | nil,
          request_id: String.t(),
          access_token: String.t() | nil
        }

  defstruct [
    :item,
    :status,
    :request_id,
    :access_token
  ]

  @impl true
  def cast(generic_map) do
    %__MODULE__{
      item: Castable.cast(Item, generic_map["item"]),
      status: Castable.cast(Status, generic_map["status"]),
      request_id: generic_map["request_id"],
      access_token: generic_map["access_token"]
    }
  end
end
