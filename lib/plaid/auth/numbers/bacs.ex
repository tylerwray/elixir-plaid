defmodule Plaid.Auth.Numbers.BACS do
  @moduledoc """
  [Plaid Numbers BACS schema](https://plaid.com/docs/api/products/#auth-get-response-bacs).
  """

  @type t :: %__MODULE__{
          account: String.t(),
          account_id: String.t(),
          sort_code: String.t()
        }

  defstruct [
    :account,
    :account_id,
    :sort_code
  ]
end
