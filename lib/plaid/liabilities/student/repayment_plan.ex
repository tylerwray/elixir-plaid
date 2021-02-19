defmodule Plaid.Liabilities.Student.RepaymentPlan do
  @moduledoc """
  [Plaid Liabilities Student Repayment Plan Schema.](https://plaid.com/docs/api/products/#liabilities-get-response-repayment-plan)
  """

  @behaviour Plaid.Castable

  alias Plaid.Castable

  @type t :: %__MODULE__{
          description: String.t() | nil,
          type: String.t() | nil
        }

  defstruct [
    :description,
    :type
  ]

  @impl Castable
  def cast(generic_map) do
    %__MODULE__{
      description: generic_map["description"],
      type: generic_map["type"],
    }
  end
end
