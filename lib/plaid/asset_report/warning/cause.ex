defmodule Plaid.AssetReport.Warning.Cause do
  @moduledoc """
  [Plaid Asset Report Warning Cause schema](https://plaid.com/docs/api/products/#asset_report-get-response-cause)
  """

  @type t :: %__MODULE__{
          item_id: String.t(),
          error: Plaid.Error.t() | nil
        }

  defstruct [
    :item_id,
    :error
  ]
end
