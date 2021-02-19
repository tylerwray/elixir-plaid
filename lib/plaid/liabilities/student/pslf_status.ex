defmodule Plaid.Liabilities.Student.PSLFStatus do
  @moduledoc """
  [Plaid Liabilities Student PSLF Status Schema.](https://plaid.com/docs/api/products/#liabilities-get-response-pslf-status)
  """

  @behaviour Plaid.Castable

  alias Plaid.Castable

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

  @impl Castable
  def cast(generic_map) do
    %__MODULE__{
      estimated_eligibility_date: generic_map["estimated_eligibility_date"],
      payments_made: generic_map["payments_made"],
      payments_remaining: generic_map["payments_remaining"]
    }
  end
end
