defmodule Plaid.Identity.Email do
  @moduledoc """
  [Plaid Identity Email schema.](https://plaid.com/docs/api/products/#identity-get-response-emails)
  """

  @type t :: %__MODULE__{
          data: String.t(),
          primary: boolean(),
          type: String.t()
        }

  defstruct [
    :data,
    :primary,
    :type
  ]
end
