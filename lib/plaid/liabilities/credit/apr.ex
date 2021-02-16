defmodule Plaid.Liabilities.Credit.APR do
  @moduledoc """
  [Plaid Liabilities Credit APR Schema.](https://plaid.com/docs/api/products/#liabilities-get-response-aprs)
  """

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
end
