defmodule Plaid.SimpleResponse do
  @moduledoc """
  The most simple response that the Plaid API provides.
  """

  @behaviour Plaid.Castable

  alias Plaid.Castable

  @type t :: %__MODULE__{
          request_id: String.t()
        }

  defstruct [
    :request_id
  ]

  @impl Castable
  def cast(generic_map) do
    %__MODULE__{
      request_id: generic_map["request_id"]
    }
  end
end
