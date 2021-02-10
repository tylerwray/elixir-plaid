defmodule Plaid.Util do
  @moduledoc false

  @doc """
  Put a key-value pair on a map, only if it exists in a source map.

  ## Examples

      iex> maybe_put(%{foo: "bar"}, :test, %{test: 1})
      %{foo: "bar", test: 1}

      iex> maybe_put(%{}, :stuff, %{test: 1})
      %{}

  """
  @spec maybe_put(map(), any(), map()) :: map()
  def maybe_put(map, key, source) do
    case Map.has_key?(source, key) do
      true -> Map.put(map, key, Map.get(source, key))
      false -> map
    end
  end
end
