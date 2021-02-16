defmodule Plaid.Liabilities.Student.PSLFStatus do
  @moduledoc """
  [Plaid Liabilities Student PSLF Status Schema.](https://plaid.com/docs/api/products/#liabilities-get-response-pslf-status)
  """

  @type t :: %__MODULE__{
          estimated_eligibility_date: String.t() | nil,
          payments_made: number() | nil,
          payments_remaining: number() | nil
        }

  defstruct [
    :estimated_eligibility_date,
    :payments_made,
    :payments_remaining
  ]
end
