defmodule Plaid.Identity.Match.Account.Address do
  @moduledoc """
  Struct for Plaid's [Identity Match Address](https://plaid.com/docs/api/products/identity/#identity-match-response-accounts-address) object.
  """
  @behaviour Plaid.Castable

  @type t :: %__MODULE__{
          score: integer() | nil,
          is_postal_code_match: boolean() | nil
        }

  defstruct [:score, :is_postal_code_match]

  @impl true
  def cast(map) do
    %__MODULE__{
      score: map["score"],
      is_postal_code_match: map["is_postal_code_match"]
    }
  end
end
