defmodule Plaid.Item.UpdateWebhookResponse do
  @moduledoc """
  [Plaid API /item/webhook/update response schema.](https://plaid.com/docs/api/items/#itemwebhookupdate)
  """

  @behaviour Plaid.Castable

  alias Plaid.Castable
  alias Plaid.Item

  @type t :: %__MODULE__{
          item: Item.t(),
          request_id: String.t()
        }

  defstruct [
    :item,
    :request_id
  ]

  @impl true
  def cast(generic_map) do
    %__MODULE__{
      item: Castable.cast(Item, generic_map["item"]),
      request_id: generic_map["request_id"]
    }
  end
end
