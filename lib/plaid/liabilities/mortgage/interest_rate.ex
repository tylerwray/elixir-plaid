defmodule Plaid.Liabilities.Mortgage.InterestRate do
  @moduledoc """
  [Plaid Liabilities Mortage Interest Rate Schema.](https://plaid.com/docs/api/products/#liabilities-get-response-interest-rate)
  """

  @behaviour Plaid.Castable

  alias Plaid.Castable

  @type t :: %__MODULE__{
          percentage: number() | nil,
          type: String.t() | nil
        }

  defstruct [
    :percentage,
    :type
  ]

  @impl Castable
  def cast(generic_map) do
    %__MODULE__{
      percentage: generic_map["percentage"],
      type: generic_map["type"]
    }
  end
end
