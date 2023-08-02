defmodule Plaid.Identity.Match.Account.PhoneNumber do
  @moduledoc """
  Struct for Plaid's [Identity Match Phone Number](https://plaid.com/docs/api/products/identity/#identity-match-response-accounts-phone-number) object.
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
