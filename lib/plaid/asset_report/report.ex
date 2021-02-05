defmodule Plaid.AssetReport.Report do
  @moduledoc """
  [Plaid Asset Report schema](https://plaid.com/docs/api/products/#asset_reportget)
  """

  @type t :: %__MODULE__{
          asset_report_id: String.t(),
          client_report_id: String.t(),
          # TODO: Maybe use date string type?
          date_generated: String.t(),
          days_requested: non_neg_integer(),
          items: list(Plaid.AssetReport.Report.Item.t()),
          user: Plaid.AssetReport.User.t()
        }

  defstruct [
    :asset_report_id,
    :client_report_id,
    :date_generated,
    :days_requested,
    :items,
    :user
  ]
end
