defmodule Plaid.Auth.Numbers.International do
  @moduledoc """
  [Plaid Numbers International schema](https://plaid.com/docs/api/products/#auth-get-response-international).
  """

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
end
