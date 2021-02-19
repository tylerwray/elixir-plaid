defmodule Plaid.Categories.Category do
  @moduledoc """
  [Plaid Category schema.](https://plaid.com/docs/api/products/#categoriesget)
  """

  @behaviour Plaid.Castable

  @type t :: %__MODULE__{
          category_id: String.t(),
          group: String.t(),
          hierarchy: [String.t()]
        }

  defstruct [
    :category_id,
    :group,
    :hierarchy
  ]

  @impl true
  def cast(generic_map) do
    %__MODULE__{
      category_id: generic_map["category_id"],
      group: generic_map["group"],
      hierarchy: generic_map["hierarchy"]
    }
  end
end
