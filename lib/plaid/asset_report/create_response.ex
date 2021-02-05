defmodule Plaid.AssetReport.CreateResponse do
  @moduledoc """
  [Plaid create asset report response schema.](https://plaid.com/docs/api/products/#asset_reportcreate)
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
