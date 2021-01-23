defmodule Plaid.Auth.Numbers do
  @moduledoc """
  [Plaid Numbers schema](https://plaid.com/docs/api/products/#auth-get-response-numbers).
  """

  @type t :: %__MODULE__{
          ach: list(Plaid.Auth.Numbers.ACH.t()),
          eft: list(Plaid.Auth.Numbers.EFT.t()),
          international: list(Plaid.Auth.Numbers.International.t()),
          bacs: list(Plaid.Auth.Numbers.BACS.t())
        }

  defstruct [
    :ach,
    :eft,
    :international,
    :bacs
  ]
end
