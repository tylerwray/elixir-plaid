defmodule Plaid.Auth.Numbers.ACH do
  @moduledoc """
  [Plaid Numbers ACH schema](https://plaid.com/docs/api/products/#auth-get-response-ach).
  """

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
end
