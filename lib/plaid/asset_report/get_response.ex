defmodule Plaid.AssetReport.GetResponse do
  @moduledoc """
  [Plaid Asset Report Get Response schema](https://plaid.com/docs/api/products/#asset_reportget)
  """

  @type t :: %__MODULE__{
          report: Plaid.AssetReport.Report.t(),
          warnings: list(Plaid.AssetReport.Warning.t()),
          request_id: String.t()
        }

  defstruct [
    :report,
    :warnings,
    :request_id
  ]
end
