defmodule Plaid.Categories do
  @moduledoc """
  [Plaid Categories API](https://plaid.com/docs/api/products/#categoriesget) calls and schema.
  """

  @doc """
  Get information about all Plaid categories.

  Does a `POST /categories/get` call to retrieve a list of all categories.

  > No authentication required.

  ## Example

      get()
      {:ok, %Plaid.Categories.GetResponse{}}

  """
  @spec get(Plaid.noauth_config()) ::
          {:ok, Plaid.Categories.GetResponse.t()} | {:error, Plaid.Error.t()}
  def get(config \\ []) do
    Plaid.Client.call(
      "/categories/get",
      %{},
      Plaid.Categories.GetResponse,
      config
    )
  end
end
