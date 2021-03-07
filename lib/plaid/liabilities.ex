defmodule Plaid.Liabilities do
  @moduledoc """
  [Plaid Liabilities API](https://plaid.com/docs/api/products/#liabilities) calls and schema.
  """

  @behaviour Plaid.Castable

  alias Plaid.Castable
  alias Plaid.Liabilities.{Credit, Mortgage, Student}
  alias __MODULE__

  @type t :: %__MODULE__{
          credit: [Credit.t()],
          mortgage: [Mortgage.t()],
          student: [Student.t()]
        }

  defstruct [
    :credit,
    :mortgage,
    :student
  ]

  @impl true
  def cast(generic_map) do
    %__MODULE__{
      credit: Castable.cast_list(Credit, generic_map["credit"]),
      mortgage: Castable.cast_list(Mortgage, generic_map["mortgage"]),
      student: Castable.cast_list(Student, generic_map["student"])
    }
  end

  defmodule GetResponse do
    @moduledoc """
    [Plaid API /liabilities/get response schema.](https://plaid.com/docs/api/products/#liabilitiesget)
    """

    @behaviour Castable

    alias Plaid.Accounts.Account
    alias Plaid.Item

    @type t :: %__MODULE__{
            accounts: [Account.t()],
            item: Item.t(),
            liabilities: Liabilities.t(),
            request_id: String.t()
          }

    defstruct [
      :accounts,
      :item,
      :liabilities,
      :request_id
    ]

    @impl true
    def cast(generic_map) do
      %__MODULE__{
        accounts: Castable.cast_list(Account, generic_map["accounts"]),
        item: Castable.cast(Item, generic_map["item"]),
        liabilities: Castable.cast(Liabilities, generic_map["liabilities"]),
        request_id: generic_map["request_id"]
      }
    end
  end

  @doc """
  Get liabilities information.

  Does a `POST /liabilities/get` call which fetches liabilities associated
  with an access_token's item.

  Params:
  * `access_token` - Token to fetch liabilities for.

  Options:
  * `account_ids` - Specific account ids to fetch liabilities for.

  ## Examples

      get("access-sandbox-123xxx", client_id: "123", secret: "abc")
      {:ok, %Plaid.Liabilities.GetResponse{}}

  """
  @spec get(String.t(), options, Plaid.config()) ::
          {:ok, Plaid.Liabilities.GetResponse.t()} | {:error, Plaid.Error.t()}
        when options: %{optional(:account_ids) => [String.t()]}
  def get(access_token, options \\ %{}, config) do
    options_payload = Map.take(options, [:account_ids])

    payload = %{access_token: access_token, options: options_payload}

    Plaid.Client.call(
      "/liabilities/get",
      payload,
      GetResponse,
      config
    )
  end
end
