defmodule Plaid.Liabilities.Student.LoanStatus do
  @moduledoc """
  [Plaid Liabilities Student Loan Status Schema.](https://plaid.com/docs/api/products/#liabilities-get-response-loan-status)
  """

  @behaviour Plaid.Castable

  @type t :: %__MODULE__{
          end_date: String.t() | nil,
          type: String.t() | nil
        }

  defstruct [
    :end_date,
    :type
  ]

  @impl true
  def cast(generic_map) do
    %__MODULE__{
      end_date: generic_map["end_date"],
      type: generic_map["type"]
    }
  end
end
