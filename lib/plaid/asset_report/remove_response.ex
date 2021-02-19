defmodule Plaid.AssetReport.RemoveResponse do
  @moduledoc """
  [Plaid Asset Report remove response schema.](https://plaid.com/docs/api/products/#asset_reportremove)
  """

  @behaviour Plaid.Castable

  @type t :: %__MODULE__{
          removed: boolean(),
          request_id: String.t()
        }

  defstruct [
    :removed,
    :request_id
  ]

  @impl true
  def cast(generic_map) do
    %__MODULE__{
      removed: generic_map["removed"],
      request_id: generic_map["request_id"]
    }
  end
end
