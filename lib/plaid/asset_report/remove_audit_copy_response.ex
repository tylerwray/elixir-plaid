defmodule Plaid.AssetReport.RemoveAuditCopyResponse do
  @moduledoc """
  [Plaid Asset Report remove audit copy response schema.](https://plaid.com/docs/api/products/#asset_reportaudit_copyremove)
  """

  @behaviour Plaid.Castable

  alias Plaid.Castable

  @type t :: %__MODULE__{
          removed: boolean(),
          request_id: String.t()
        }

  defstruct [
    :removed,
    :request_id
  ]

  @impl Castable
  def cast(generic_map) do
    %__MODULE__{
      removed: generic_map["removed"],
      request_id: generic_map["request_id"]
    }
  end
end
