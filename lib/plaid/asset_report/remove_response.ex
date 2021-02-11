defmodule Plaid.AssetReport.RemoveResponse do
  @moduledoc """
  [Plaid Asset Report remove response schema.](https://plaid.com/docs/api/products/#asset_reportremove)
  """

  @type t :: %__MODULE__{
          removed: boolean(),
          request_id: String.t()
        }

  defstruct [
    :removed,
    :request_id
  ]
end
