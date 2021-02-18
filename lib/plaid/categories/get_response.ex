defmodule Plaid.Categories.GetResponse do
  @moduledoc """
  [Plaid /categories/get API response](https://plaid.com/docs/api/products/#categoriesget).
  """

  @behaviour Plaid.Castable

  alias Plaid.Categories.Category

  @type t :: %__MODULE__{
          categories: [Category.t()],
          request_id: String.t()
        }

  defstruct [
    :categories,
    :request_id
  ]

  @impl Plaid.Castable
  def cast(generic_map) do
    %__MODULE__{
      categories: Enum.map(generic_map["categories"], &Category.cast/1),
      request_id: generic_map["request_id"]
    }
  end
end
