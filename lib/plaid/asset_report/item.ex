defmodule Plaid.AssetReport.Report.Item do
  @moduledoc """
  [Plaid Asset Report Item schema](https://plaid.com/docs/api/products/#asset_report-get-response-items)
  """
  @type t :: %__MODULE__{
          item_id: String.t(),
          institution_name: String.t(),
          institution_id: String.t(),
          date_last_updated: String.t(),
          accounts: list(Plaid.Accounts.Account.t())
        }

  defstruct [
    :item_id,
    :institution_name,
    :institution_id,
    :date_last_updated,
    :accounts
  ]
end
