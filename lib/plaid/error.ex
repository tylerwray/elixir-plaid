defmodule Plaid.Error do
  @moduledoc """
  [Plaid API Error response Schema.](https://plaid.com/docs/errors/)
  """

  @type t :: %__MODULE__{
          error_type: String.t(),
          error_code: String.t(),
          error_message: String.t(),
          display_message: String.t() | nil,
          request_id: String.t() | nil,
          # TODO: Put proper type in this list
          causes: list(),
          status: integer() | nil,
          documentation_url: String.t() | nil,
          suggested_action: String.t() | nil
        }

  defstruct [
    :error_type,
    :error_code,
    :error_message,
    :display_message,
    :request_id,
    :causes,
    :status,
    :documentation_url,
    :suggested_action
  ]
end
