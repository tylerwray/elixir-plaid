defmodule Plaid.Identity.Match.Account.LegalName do
  @moduledoc """
  [Plaid Identity Match Legal Name schema.](https://plaid.com/docs/api/products/identity/#identity-match-response-accounts-legal-name).
  """
  @behaviour Plaid.Castable

  @type t :: %__MODULE__{
          score: integer() | nil,
          is_nickname_match: boolean() | nil,
          is_first_name_or_last_name_match: boolean() | nil,
          is_business_name_detected: boolean() | nil
        }

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
