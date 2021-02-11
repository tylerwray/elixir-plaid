defmodule Plaid.AssetReport.AsyncResponse do
  @moduledoc """
  Plaid asset-report response schema used when generating asset reports.

  Async because it only returns a token, the actual asset-report needs to
  be fetched after the proper webhook is received. [See docs.](https://plaid.com/docs/api/products/#asset_reportcreate)
  """

  @type t :: %__MODULE__{
          asset_report_token: String.t(),
          asset_report_id: String.t(),
          request_id: String.t()
        }

  defstruct [
    :asset_report_token,
    :asset_report_id,
    :request_id
  ]
end
