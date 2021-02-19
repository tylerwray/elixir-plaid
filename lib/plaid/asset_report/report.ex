defmodule Plaid.AssetReport.Report do
  @moduledoc """
  [Plaid Asset Report schema](https://plaid.com/docs/api/products/#asset_reportget)
  """

  @behaviour Plaid.Castable

  alias Plaid.AssetReport.Report
  alias Plaid.AssetReport.User
  alias Plaid.Castable

  @type t :: %__MODULE__{
          asset_report_id: String.t(),
          client_report_id: String.t(),
          date_generated: String.t(),
          days_requested: non_neg_integer(),
          items: [Report.Item.t()],
          user: User.t()
        }

  defstruct [
    :asset_report_id,
    :client_report_id,
    :date_generated,
    :days_requested,
    :items,
    :user
  ]

  @impl true
  def cast(generic_map) do
    %__MODULE__{
      asset_report_id: generic_map["asset_report_id"],
      client_report_id: generic_map["client_report_id"],
      date_generated: generic_map["date_generated"],
      days_requested: generic_map["days_requested"],
      items: Castable.cast_list(Report.Item, generic_map["items"]),
      user: Castable.cast(User, generic_map["user"])
    }
  end
end
