defmodule Plaid.Accounts.Account.Balances do
  @moduledoc """
  Plaid Balances schema.
  https://plaid.com/docs/api/accounts
  """

  @type t :: %__MODULE__{
          available: float() | nil,
          current: float(),
          limit: float() | nil,
          iso_currency_code: String.t() | nil,
          unofficial_currency_code: String.t() | nil
        }

  defstruct [
    :available,
    :current,
    :limit,
    :iso_currency_code,
    :unofficial_currency_code
  ]
end
