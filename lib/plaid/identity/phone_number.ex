defmodule Plaid.Identity.PhoneNumber do
  @moduledoc """
  [Plaid Identity Phone Number schema.](https://plaid.com/docs/api/products/#identity-get-response-phone-numbers)
  """

  @type t :: %__MODULE__{
          data: String.t(),
          primary: boolean() | nil,
          type: String.t() | nil
        }

  defstruct [
    :data,
    :primary,
    :type
  ]
end
