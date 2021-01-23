defmodule Plaid.Categories.Category do
  @moduledoc """
  [Plaid Category schema.](https://plaid.com/docs/api/products/#categoriesget)
  """

  @type t :: %__MODULE__{
          category_id: String.t(),
          group: String.t(),
          hierarchy: list(String.t())
        }

  defstruct [
    :category_id,
    :group,
    :hierarchy
  ]
end
