defmodule Plaid.Liabilities.Student.RepaymentPlan do
  @moduledoc """
  [Plaid Liabilities Student Repayment Plan Schema.](https://plaid.com/docs/api/products/#liabilities-get-response-repayment-plan)
  """

  @type t :: %__MODULE__{
          description: String.t() | nil,
          type: String.t() | nil
        }

  defstruct [
    :description,
    :type
  ]
end
