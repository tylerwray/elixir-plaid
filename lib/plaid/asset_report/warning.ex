defmodule Plaid.AssetReport.Warning do
  @moduledoc """
  [Plaid Asset Report Warning schema](https://plaid.com/docs/api/products/#asset_report-get-response-warnings)
  """

  @behaviour Plaid.Castable

  alias Plaid.Castable
  alias Plaid.AssetReport.Warning.Cause

  @type t :: %__MODULE__{
          warning_type: String.t(),
          warning_code: String.t(),
          cause: Cause.t()
        }

  defstruct [
    :warning_type,
    :warning_code,
    :cause
  ]

  @impl true
  def cast(generic_map) do
    %__MODULE__{
      warning_type: generic_map["warning_type"],
      warning_code: generic_map["warning_code"],
      cause: Castable.cast(Cause, generic_map["cause"])
    }
  end
end
