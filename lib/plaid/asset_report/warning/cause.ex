defmodule Plaid.AssetReport.Warning.Cause do
  @moduledoc """
  [Plaid Asset Report Warning Cause schema](https://plaid.com/docs/api/products/#asset_report-get-response-cause)
  """

  @behaviour Plaid.Castable

  alias Plaid.Castable

  @type t :: %__MODULE__{
          item_id: String.t(),
          error: Plaid.Error.t() | nil
        }

  defstruct [
    :item_id,
    :error
  ]

  @impl Castable
  def cast(generic_map) do
    %__MODULE__{
      item_id: generic_map["item_id"],
      error: Castable.cast(Plaid.Error, generic_map["error"])
    }
  end
end
