defmodule Plaid.Categories do
  @moduledoc """
  [Plaid Categories API](https://plaid.com/docs/api/products/#categoriesget) calls and schema.
  """

  defmodule GetResponse do
    @moduledoc """
    [Plaid /categories/get API response schema.](https://plaid.com/docs/api/products/#categoriesget).
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

  @doc """
  Get information about all Plaid categories.

  Does a `POST /categories/get` call to retrieve a list of all categories.

  > No authentication required.

  ## Example

      get()
      {:ok, %GetResponse{}}

  """
  @spec get(Plaid.noauth_config()) :: {:ok, GetResponse.t()} | {:error, Plaid.Error.t()}
  def get(config \\ []) do
    Plaid.Client.call(
      "/categories/get",
      %{},
      GetResponse,
      config
    )
  end
end
