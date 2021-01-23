defmodule Plaid.SimpleResponse do
  @moduledoc """
  The most simple response that the Plaid API provides.
  """

  @type t :: %__MODULE__{request_id: String.t()}

  defstruct [:request_id]
end
