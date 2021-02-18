defmodule Plaid.Auth.Numbers.International do
  @moduledoc """
  [Plaid Numbers International schema](https://plaid.com/docs/api/products/#auth-get-response-international).
  """

  @behaviour Plaid.Castable

  alias Plaid.Castable

  @type t :: %__MODULE__{
          account_id: String.t(),
          iban: String.t(),
          bic: String.t()
        }

  defstruct [
    :account_id,
    :iban,
    :bic
  ]

  @impl Castable
  def cast(generic_map) do
    %__MODULE__{
      account_id: generic_map["account_id"],
      iban: generic_map["iban"],
      bic: generic_map["bic"]
    }
  end
end
