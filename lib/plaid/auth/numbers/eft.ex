defmodule Plaid.Auth.Numbers.EFT do
  @moduledoc """
  [Plaid Numbers EFT schema](https://plaid.com/docs/api/products/#auth-get-response-eft).
  """

  @type t :: %__MODULE__{
          account: String.t(),
          account_id: String.t(),
          institution: String.t(),
          branch: String.t()
        }

  defstruct [
    :account,
    :account_id,
    :institution,
    :branch
  ]
end
