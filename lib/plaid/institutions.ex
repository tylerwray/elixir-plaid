defmodule Plaid.Institutions do
  @moduledoc """
  [Plaid Institutions API](https://plaid.com/docs/api/institutions/) calls and schema.
  """

  defmodule GetResponse do
    @moduledoc """
    [Plaid API /institutions/get response schema.](https://plaid.com/docs/api/institutions/#institutionsget)
    """

    @behaviour Plaid.Castable

    alias Plaid.Castable
    alias Plaid.Institution

    @type t :: %__MODULE__{
            institutions: [Institution.t()],
            total: integer(),
            request_id: String.t()
          }

    defstruct [
      :institutions,
      :total,
      :request_id
    ]

    @impl true
    def cast(generic_map) do
      %__MODULE__{
        institutions: Castable.cast_list(Institution, generic_map["institutions"]),
        total: generic_map["total"],
        request_id: generic_map["request_id"]
      }
    end
  end

  defmodule GetByIdResponse do
    @moduledoc """
    [Plaid API /institutions/get_by_id response schema.](https://plaid.com/docs/api/institutions/#institutionsget_by_id)
    """

    @behaviour Plaid.Castable

    alias Plaid.Castable
    alias Plaid.Institution

    @type t :: %__MODULE__{
            institution: Institution.t(),
            request_id: String.t()
          }

    defstruct [
      :institution,
      :request_id
    ]

    @impl true
    def cast(generic_map) do
      %__MODULE__{
        institution: Castable.cast(Institution, generic_map["institution"]),
        request_id: generic_map["request_id"]
      }
    end
  end

  @doc """
  Get information about Plaid institutions.
    
  Does a `POST /institutions/get` call to list the supported Plaid
  institutions with their details.
    
  ## Params
  * `:count` - The total number of Institutions to return.
  * `:offset` - The number of Institutions to skip.
  * `:country_codes` - Array of country codes the institution supports.

  ## Options
  * `:products` - Filter based on which products they support.
  * `:routing_numbers` - Filter based on routing numbers.
  * `:oauth` - Filter institutions with or without OAuth login flows. 
  * `:include_optional_metadata` - When true, return the institution's homepage URL, logo and primary brand color.

  ## Examples

      Institutions.get(%{count: 25, offset: 0, country_codes: ["CA", "GB]}, client_id: "123", secret: "abc")
      {:ok, %Institutions.GetResponse{}}

  """
  @spec get(params, options, Plaid.config()) :: {:ok, GetResponse.t()} | {:error, Plaid.Error.t()}
        when params: %{
               required(:count) => integer(),
               required(:offset) => integer(),
               required(:country_codes) => [String.t()]
             },
             options: %{
               optional(:products) => [String.t()],
               optional(:routing_numbers) => [String.t()],
               optional(:oauth) => boolean(),
               optional(:include_optional_metadata) => boolean()
             }
  def get(params, options \\ %{}, config) do
    options_payload =
      Map.take(options, [:products, :routing_numbers, :oauth, :include_optional_metadata])

    payload =
      params
      |> Map.take([:count, :offset, :country_codes])
      |> Map.merge(%{options: options_payload})

    Plaid.Client.call(
      "/institutions/get",
      payload,
      GetResponse,
      config
    )
  end

  @doc """
  Get information about a Plaid institution.

  Does a `POST /institutions/get_by_id` call to retrieve a Plaid
  institution by it's ID.

  ## Params
  * `institution_id` - The ID of the institution to get details about.
  * `country_codes` - Array of country codes the institution supports.

  ## Options
  * `:include_optional_metadata` - When true, return the institution's homepage URL, logo and primary brand color.
  * `:include_status` - When true, the response will include status information about the institution.

  ## Examples

      Institutions.get_by_id("ins_1", ["CA", "GB], client_id: "123", secret: "abc")
      {:ok, %Institutions.GetByIdResponse{}}

  """
  @spec get_by_id(String.t(), [String.t()], options, Plaid.config()) ::
          {:ok, GetByIdResponse.t()} | {:error, Plaid.Error.t()}
        when options: %{
               optional(:products) => [String.t()],
               optional(:routing_numbers) => [String.t()],
               optional(:oauth) => boolean(),
               optional(:include_optional_metadata) => boolean()
             }
  def get_by_id(institution_id, country_codes, options \\ %{}, config) do
    options_payload = Map.take(options, [:include_optional_metadata, :include_status])

    payload =
      %{}
      |> Map.put(:institution_id, institution_id)
      |> Map.put(:country_codes, country_codes)
      |> Map.merge(%{options: options_payload})

    Plaid.Client.call(
      "/institutions/get_by_id",
      payload,
      GetByIdResponse,
      config
    )
  end
end
