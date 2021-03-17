defmodule Plaid.LinkToken.Metadata do
  @moduledoc """
  [Plaid link token metadata.](https://plaid.com/docs/api/tokens/#link-token-get-response-metadata)
  """

  alias Plaid.Castable

  @behaviour Castable

  defmodule Filter do
    @moduledoc """
    [Plaid link token account subtype filter.](https://plaid.com/docs/api/tokens/#link-token-get-response-depository)
    """

    @behaviour Castable

    @type t :: %__MODULE__{
            account_subtypes: [String.t()]
          }

    defstruct [:account_subtypes]

    @impl true
    def cast(generic_map) do
      %__MODULE__{
        account_subtypes: generic_map["account_subtypes"]
      }
    end
  end

  defmodule AccountFilters do
    @moduledoc """
    [Plaid link token account filters.](https://plaid.com/docs/api/tokens/#link-token-get-response-account-filters)

    > This cannot be a struct because the presence of a key with a `nil` value causes an error
    > in the plaid API.
    """

    @behaviour Castable

    @type t :: %{
            optional(:depository) => Filter.t(),
            optional(:credit) => Filter.t(),
            optional(:loan) => Filter.t(),
            optional(:investment) => Filter.t()
          }

    @impl true
    def cast(generic_map) do
      %{}
      |> Map.put(:depository, Castable.cast(Filter, generic_map["depository"]))
      |> Map.put(:credit, Castable.cast(Filter, generic_map["credit"]))
      |> Map.put(:loan, Castable.cast(Filter, generic_map["loan"]))
      |> Map.put(:investment, Castable.cast(Filter, generic_map["investment"]))
      |> Enum.reject(fn {_, v} -> is_nil(v) end)
      |> Map.new()
    end
  end

  @type t :: %__MODULE__{
          account_filters: AccountFilters.t(),
          client_name: String.t() | nil,
          country_codes: [String.t()],
          initial_products: [String.t()],
          language: String.t() | nil,
          redirect_uri: String.t() | nil,
          webhook: String.t() | nil
        }

  @derive Jason.Encoder
  defstruct [
    :account_filters,
    :client_name,
    :country_codes,
    :initial_products,
    :language,
    :redirect_uri,
    :webhook
  ]

  @impl true
  def cast(generic_map) do
    %__MODULE__{
      account_filters: Castable.cast(AccountFilters, generic_map["account_filters"]),
      client_name: generic_map["client_name"],
      country_codes: generic_map["country_codes"],
      initial_products: generic_map["initial_products"],
      language: generic_map["language"],
      redirect_uri: generic_map["redirect_uri"],
      webhook: generic_map["webhook"]
    }
  end
end
