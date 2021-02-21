defmodule Plaid.Castable do
  @moduledoc false

  @type generic_map :: %{String.t() => any()}

  @doc """
  Implement this to make a struct "castable".
  """
  @callback cast(generic_map() | nil) :: struct() | nil

  @doc """
  Take a generic string-key map and cast it into a well defined struct.

  ## Examples

      cast(MyStruct, %{"key" => "value"})
      %MyStruct{key: "value"}

  """
  @spec cast(module(), generic_map() | nil) :: generic_map() | nil
  def cast(_implementation, nil) do
    nil
  end

  def cast(implementation, generic_map) when is_map(generic_map) do
    implementation.cast(generic_map)
  end

  @doc """
  Take a list of generic string-key maps and cast them into well defined structs.

  ## Examples

      cast_list(MyStruct, [%{"a" => "b"}, %{"c" => "d"}])
      [%MyStruct{a: "b"}, %MyStruct{c: "d"}]

  """
  @spec cast_list(module(), [generic_map()] | nil) :: [struct()] | nil
  def cast_list(_implementation, nil) do
    nil
  end

  def cast_list(implementation, list_of_generic_maps) when is_list(list_of_generic_maps) do
    Enum.map(list_of_generic_maps, &implementation.cast/1)
  end
end
