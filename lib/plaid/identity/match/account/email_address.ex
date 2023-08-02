defmodule Plaid.Identity.Match.Account.EmailAddress do
  @moduledoc """
  Struct for Plaid's [Identity Match EmailAddress](https://plaid.com/docs/api/products/identity/#identity-match-response-accounts-email-address) object.
  """

  @behaviour Plaid.Castable

  @type t :: %__MODULE__{
          score: integer() | nil
        }

  defstruct [:score]

  @impl true
  def cast(map) do
    %__MODULE__{score: map["score"]}
  end
end
