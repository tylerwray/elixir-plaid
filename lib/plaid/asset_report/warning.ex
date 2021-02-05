defmodule Plaid.AssetReport.Warning do
  @moduledoc """
  [Plaid Asset Report Warning schema](https://plaid.com/docs/api/products/#asset_report-get-response-warnings)
  """

  @type t :: %__MODULE__{
          warning_type: String.t(),
          warning_code: String.t(),
          cause: Plaid.AssetReport.Warning.Cause.t()
        }

  defstruct [
    :warning_type,
    :warning_code,
    :cause
  ]
end
