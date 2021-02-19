defmodule Plaid.Liabilities.Credit.APR do
  @moduledoc """
  [Plaid Liabilities Credit APR Schema.](https://plaid.com/docs/api/products/#liabilities-get-response-aprs)
  """

  @behaviour Plaid.Castable

  @type t :: %__MODULE__{
          apr_percentage: number(),
          apr_type: String.t(),
          balance_subject_to_apr: number() | nil,
          interest_charge_amount: number() | nil
        }

  defstruct [
    :apr_percentage,
    :apr_type,
    :balance_subject_to_apr,
    :interest_charge_amount
  ]

  @impl true
  def cast(generic_map) do
    %__MODULE__{
      apr_percentage: generic_map["apr_percentage"],
      apr_type: generic_map["apr_type"],
      balance_subject_to_apr: generic_map["balance_subject_to_apr"],
      interest_charge_amount: generic_map["interest_charge_amount"]
    }
  end
end
