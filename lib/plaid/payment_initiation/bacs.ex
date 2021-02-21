defmodule Plaid.PaymentInitiation.BACS do
  @moduledoc """
  [Plaid payment initiation recipient BACS details.](https://plaid.com/docs/api/products/#payment_initiation-recipient-create-request-bacs)
  """

  @behaviour Plaid.Castable

  @type t :: %__MODULE__{
          account: String.t(),
          sort_code: String.t()
        }

  @derive Jason.Encoder
  defstruct [
    :account,
    :sort_code
  ]

  @impl true
  def cast(generic_map) do
    %__MODULE__{
      account: generic_map["account"],
      sort_code: generic_map["sort_code"]
    }
  end
end
