defmodule Plaid.Identity.Email do
  @moduledoc """
  [Plaid Identity Email schema.](https://plaid.com/docs/api/products/#identity-get-response-emails)
  """

  @behaviour Plaid.Castable

  alias Plaid.Castable

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

  @impl Castable
  def cast(generic_map) do
    %__MODULE__{
      data: generic_map["data"],
      primary: generic_map["primary"],
      type: generic_map["type"]
    }
  end
end
