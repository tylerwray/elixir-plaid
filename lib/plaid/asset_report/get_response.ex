defmodule Plaid.AssetReport.GetResponse do
  @moduledoc """
  [Plaid Asset Report Get Response schema](https://plaid.com/docs/api/products/#asset_reportget)
  """

  @behaviour Plaid.Castable

  alias Plaid.Castable
  alias Plaid.AssetReport.{Report, Warning}

  @type t :: %__MODULE__{
          report: Report.t(),
          warnings: list(Warning.t()),
          request_id: String.t()
        }

  defstruct [
    :report,
    :warnings,
    :request_id
  ]

  @impl Castable
  def cast(generic_map) do
    %__MODULE__{
      report: Castable.cast(Report, generic_map["report"]),
      warnings: Castable.cast_list(Warning, generic_map["warnings"]),
      request_id: generic_map["request_id"]
    }
  end
end
