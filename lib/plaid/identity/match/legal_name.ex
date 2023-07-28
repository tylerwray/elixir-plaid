defmodule Plaid.Identity.Match.LegalName do
  @behaviour Plaid.Castable

  defstruct [
    :score,
    :is_nickname_match,
    :is_first_name_or_last_name_match,
    :is_business_name_detected
  ]

  @impl true
  def cast(map) do
    %__MODULE__{
      score: map["score"],
      is_nickname_match: map["is_nickname_match"],
      is_first_name_or_last_name_match: map["is_first_name_or_last_name_match"],
      is_business_name_detected: map["is_business_name_detected"]
    }
  end
end
