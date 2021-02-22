defmodule Plaid.Item.Status.Investments do
  @moduledoc """
  [Plaid item status investments information.](https://plaid.com/docs/api/items/#item-get-response-investments)
  """

  @behaviour Plaid.Castable

  @type t :: %__MODULE__{
          last_successful_update: String.t() | nil,
          last_failed_update: String.t() | nil
        }

  defstruct [
    :last_successful_update,
    :last_failed_update
  ]

  @impl true
  def cast(generic_map) do
    %__MODULE__{
      last_successful_update: generic_map["last_successful_update"],
      last_failed_update: generic_map["last_failed_update"]
    }
  end
end
