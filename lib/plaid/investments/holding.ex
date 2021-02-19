defmodule Plaid.Investments.Holding do
  @moduledoc """
  [Plaid Investments Holding schema](https://plaid.com/docs/api/products/#investments-holdings-get-response-holdings)
  """

  @behaviour Plaid.Castable

  alias Plaid.Castable

  @type t :: %__MODULE__{
          account_id: String.t(),
          security_id: String.t(),
          institution_price: number(),
          institution_price_as_of: String.t() | nil,
          institution_value: number(),
          cost_basis: number() | nil,
          quantity: number(),
          iso_currency_code: String.t() | nil,
          unofficial_currency_code: String.t() | nil
        }

  defstruct [
    :account_id,
    :cost_basis,
    :institution_price,
    :institution_price_as_of,
    :institution_value,
    :iso_currency_code,
    :quantity,
    :security_id,
    :unofficial_currency_code
  ]

  @impl Castable
  def cast(generic_map) do
    %__MODULE__{
      account_id: generic_map["account_id"],
      cost_basis: generic_map["cost_basis"],
      institution_price: generic_map["institution_price"],
      institution_price_as_of: generic_map["institution_price_as_of"],
      institution_value: generic_map["institution_value"],
      iso_currency_code: generic_map["iso_currency_code"],
      quantity: generic_map["quantity"],
      security_id: generic_map["security_id"],
      unofficial_currency_code: generic_map["unofficial_currency_code"]
    }
  end
end
