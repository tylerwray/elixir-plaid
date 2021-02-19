defmodule Plaid.AssetReport.Report.Item do
  @moduledoc """
  [Plaid Asset Report Item schema](https://plaid.com/docs/api/products/#asset_report-get-response-items)
  """

  @behaviour Plaid.Castable

  alias Plaid.Accounts.Account
  alias Plaid.Castable

  @type t :: %__MODULE__{
          item_id: String.t(),
          institution_name: String.t(),
          institution_id: String.t(),
          date_last_updated: String.t(),
          accounts: [Account.t()]
        }

  defstruct [
    :item_id,
    :institution_name,
    :institution_id,
    :date_last_updated,
    :accounts
  ]

  @impl true
  def cast(generic_map) do
    %__MODULE__{
      item_id: generic_map["item_id"],
      institution_name: generic_map["institution_name"],
      institution_id: generic_map["institution_id"],
      date_last_updated: generic_map["date_last_updated"],
      accounts: Castable.cast_list(Account, generic_map["accounts"])
    }
  end
end
