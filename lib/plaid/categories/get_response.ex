defmodule Plaid.Categories.GetResponse do
  @moduledoc """
  [Plaid /categories/get API response](https://plaid.com/docs/api/products/#categoriesget).
  """

  @behaviour Plaid.Castable

  alias Plaid.Castable
  alias Plaid.Categories.Category

  @type t :: %__MODULE__{
          categories: [Category.t()],
          request_id: String.t()
        }

  defstruct [
    :categories,
    :request_id
  ]

  @impl true
  def cast(generic_map) do
    %__MODULE__{
      categories: Castable.cast_list(Category, generic_map["categories"]),
      request_id: generic_map["request_id"]
    }
  end
end
