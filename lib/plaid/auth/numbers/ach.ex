defmodule Plaid.Auth.Numbers.ACH do
  @moduledoc """
  [Plaid Numbers ACH schema](https://plaid.com/docs/api/products/#auth-get-response-ach).
  """

  @behaviour Plaid.Castable

  @type t :: %__MODULE__{
          account: String.t(),
          account_id: String.t(),
          routing: String.t(),
          wire_routing: String.t() | nil
        }

  defstruct [
    :account,
    :account_id,
    :routing,
    :wire_routing
  ]

  @impl true
  def cast(generic_map) do
    %__MODULE__{
      account: generic_map["account"],
      account_id: generic_map["account_id"],
      routing: generic_map["routing"],
      wire_routing: generic_map["wire_routing"]
    }
  end
end
