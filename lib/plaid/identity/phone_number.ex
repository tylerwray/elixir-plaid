defmodule Plaid.Identity.PhoneNumber do
  @moduledoc """
  [Plaid Identity Phone Number schema.](https://plaid.com/docs/api/products/#identity-get-response-phone-numbers)
  """

  @behaviour Plaid.Castable

  alias Plaid.Castable

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

  @impl Castable
  def cast(generic_map) do
    %__MODULE__{
      data: generic_map["data"],
      primary: generic_map["primary"],
      type: generic_map["type"]
    }
  end
end
