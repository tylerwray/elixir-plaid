defmodule Plaid.Liabilities.Mortgage.InterestRate do
  @moduledoc """
  [Plaid Liabilities Mortage Interest Rate Schema.](https://plaid.com/docs/api/products/#liabilities-get-response-interest-rate)
  """

  @type t :: %__MODULE__{
          percentage: number() | nil,
          type: String.t() | nil
        }

  defstruct [
    :percentage,
    :type
  ]
end
