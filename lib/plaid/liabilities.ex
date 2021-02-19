defmodule Plaid.Liabilities do
  @moduledoc """
  [Plaid Liabilities API](https://plaid.com/docs/api/products/#liabilities) calls and schema.
  """

  @behaviour Plaid.Castable

  alias Plaid.Castable
  alias Plaid.Liabilities.{Credit, Mortgage, Student}

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
      Plaid.Liabilities.GetResponse,
      config
    )
  end
end
