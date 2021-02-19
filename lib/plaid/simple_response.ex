defmodule Plaid.SimpleResponse do
  @moduledoc """
  The most simple response that the Plaid API provides.
  """

  @behaviour Plaid.Castable

  @type t :: %__MODULE__{
          request_id: String.t()
        }

  defstruct [
    :request_id
  ]

  @impl true
  def cast(generic_map) do
    %__MODULE__{
      request_id: generic_map["request_id"]
    }
  end
end
