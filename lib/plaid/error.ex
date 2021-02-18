defmodule Plaid.Error do
  @moduledoc """
  [Plaid API Error response Schema.](https://plaid.com/docs/errors/)
  """

  @behaviour Plaid.Castable

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

  @impl Plaid.Castable
  def cast(generic_map) do
    %__MODULE__{
      error_type: generic_map["error_type"],
      error_code: generic_map["error_code"],
      error_message: generic_map["error_message"],
      display_message: generic_map["display_message"],
      request_id: generic_map["request_id"],
      causes: generic_map["causes"],
      status: generic_map["status"],
      documentation_url: generic_map["documentation_url"],
      suggested_action: generic_map["suggested_action"]
    }
  end
end
