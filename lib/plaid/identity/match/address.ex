defmodule Plaid.Identity.Match.Address do
  @behaviour Plaid.Castable
  defstruct [:score, :is_postal_code_match]

  @impl true
  def cast(map) do
    %__MODULE__{
      score: map["score"],
      is_postal_code_match: map["is_postal_code_match"]
    }
  end
end
