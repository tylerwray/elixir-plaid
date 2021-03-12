defmodule Plaid.Employer do
  @moduledoc """
  [Plaid Employer API](https://plaid.com/docs/api/employers/) calls and schema.

  🏗  Waiting on plaid to enable the `deposit_switch` product so I can fully test this endpoint.
  """

  @behaviour Plaid.Castable

  alias Plaid.Address
  alias Plaid.Castable
  alias __MODULE__

  @type t :: %__MODULE__{
          address: Address.t() | nil,
          confidence_score: number() | nil,
          employer_id: String.t(),
          name: String.t()
        }

  defstruct [:address, :confidence_score, :employer_id, :name]

  @impl true
  def cast(generic_map) do
    %__MODULE__{
      address: Castable.cast(Address, generic_map["address"]),
      confidence_score: generic_map["confidence_score"],
      employer_id: generic_map["employer_id"],
      name: generic_map["name"]
    }
  end

  defmodule SearchResponse do
    @moduledoc """
    [Plaid API /employers/search response schema.](https://plaid.com/docs/api/employers/#employerssearch)
    """

    @behaviour Castable

    @type t :: %__MODULE__{
            employers: [Employer.t()],
            request_id: String.t()
          }

    defstruct [:employers, :request_id]

    @impl true
    def cast(generic_map) do
      %__MODULE__{
        employers: Castable.cast_list(Employer, generic_map["employers"]),
        request_id: generic_map["request_id"]
      }
    end
  end

  @doc """
  Search employers information.

  Does a `POST /employers/search` call to search Plaid’s database of known employers,
  for use with Deposit Switch

  Params:
  * `query` - The employer name to be searched for.
  * `products` - The Plaid products the returned employers should support.

  > Currently in the Plaid API, `products` must be set to `["deposit_switch"]`.

  ## Examples

      Employer.search("Plaid", ["deposit_switch"], client_id: "123", secret: "abc")
      {:ok, %Employer.SearchResponse{}}

  """
  @spec search(String.t(), [String.t()], Plaid.config()) ::
          {:ok, SearchResponse.t()} | {:error, Plaid.Error.t()}
  def search(query, products, config) do
    Plaid.Client.call(
      "/employers/search",
      %{query: query, products: products},
      SearchResponse,
      config
    )
  end
end
