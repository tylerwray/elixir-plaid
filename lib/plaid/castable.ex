defmodule Plaid.Castable do
  @moduledoc false

  @type generic_map :: %{String.t() => any()}

  @doc """
  Core to how this library functions is the `Plaid.Castable` behaviour for casting response objects to structs.
  Each struct implements the behaviour by adding a `cast/1` fuction that take a generic string-keyed
  map and turns it into a struct of it's own type.

  `Plaid.Castable.cast/2` and `Plaid.Castable.cast_list/2` are helper functions for casting nested objects.
  Both which have the same signature taking first a module and second the string-keyed map.

  Each API call function will return some `__Response` struct. i.e. `GetResponse`, `SearchResponse`, `CreateResponse`, etc.
  This is because of how plaid's API is structured, and it follows the same pattern as the client-libraries they
  maintain in go, ruby, java, and other languages.

  Take advantage of nested modules for structs when possible and it makes sense.
  Nest all `__Response` structs next to the functions that make the API calls.

  The `Plaid.Client` module that makes all the API calls must be passed a `__Response` module that implements
  the `Plaid.Castable` behaviour. It then calls the `cast/1` function on that `__Response` module; passing
  the response body to kick off the response casting process.

  ### Made-up example

  Endpoint: `/payments/get`

  Response:

  ```json
  {
    "payment": {
      "customer_name": "Stefani Germanotta",
      "items": [
        {
          "amount": 1200,
          "name": "Toy Solider"
        },
        {
          "amount": 3100,
          "name": "Video Game"
        }
      ]
    }
  }
  ```

  Elixir structs:

  ```elixir
  defmodule Plaid.Payment do
    @behaviour Plaid.Castable

    alias Plaid.Castable

    defstruct [:customer_name, :items]

    defmodule Item do
      @behaviour Plaid.Castable

      defstruct [:amount, :name]

      @impl true
      def cast(generic_map) do
        %__MODULE__{
          amount: generic_map["amount"],
          name: generic_map["name"]
        }
      end
    end

    @impl true
    def cast(generic_map) do
      %__MODULE__{
        customer_name: generic_map["customer_name"],
        items: Castable.cast_list(Item, generic_map["items"])
      }
    end
  end
  ```

  Elixir API module:

  ```elixir
  defmodule Plaid.Payments do
    alias Plaid.Payment

    defmodule GetResponse do
      @behaviour Plaid.Castable

      alias Plaid.Castable

      defstruct [:payment, :request_id]

      @impl true
      def cast(generic_map) do
        %__MODULE__{
          payment: Castable.cast(Payment, generic_map["payment"]),
          request_id: generic_map["request_id"]
        }
      end
    end

    def get(id, config) do
      Plaid.Client.call(
        "/payments/get"
        %{id: id},
        GetResponse,
        config
      )
    end
  end
  ```

  Tying it all together in IEx:

  ```elixir
  iex> Plaid.Payments.get("5930", client_id: "123", secret: "abc")
  {:ok, %Plaid.Payments.GetResponse{
    payment: %Plaid.Payment{
      customer_name: "Stefani Germanotta"
      items: [
        %Plaid.Payment.Item{
          amount: 1200,
          name: "Toy Solider"
        },
        {
          amount: 3100,
          name: "Video Game"
        }
      ]
    }
  }}
  ```
  """
  @callback cast(generic_map() | nil) :: struct() | nil

  @doc """
  Take a generic string-key map and cast it into a well defined struct.

  Passing `:raw` as the module will just give back the string-key map; Useful for fallbacks.

  ## Examples

      cast(MyStruct, %{"key" => "value"})
      %MyStruct{key: "value"}
      
      cast(:raw, %{"key" => "value"})
      %{"key" => "value"}

  """
  @spec cast(module() | :raw, generic_map() | nil) :: generic_map() | nil
  def cast(_implementation, nil) do
    nil
  end

  def cast(:raw, generic_map) do
    generic_map
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
    Enum.map(list_of_generic_maps, &cast(implementation, &1))
  end
end
