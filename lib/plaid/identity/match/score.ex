defmodule Plaid.Identity.Match.Score do
  @behaviour Plaid.Castable
  defstruct [:score]

  @impl true
  def cast(map) do
    %__MODULE__{score: map["score"]}
  end
end
