defmodule Plaid.Liabilities.Student.LoanStatus do
  @moduledoc """
  [Plaid Liabilities Student Loan Status Schema.](https://plaid.com/docs/api/products/#liabilities-get-response-loan-status)
  """

  @type t :: %__MODULE__{
          end_date: String.t() | nil,
          type: String.t() | nil
        }

  defstruct [
    :end_date,
    :type
  ]
end
