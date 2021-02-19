defmodule Plaid.AssetReport.CreateAuditCopyResponse do
  @moduledoc """
  [Plaid Asset Report create audit copy response schema](https://plaid.com/docs/api/products/#asset_reportaudit_copycreate)
  """

  @behaviour Plaid.Castable

  @type t :: %__MODULE__{
          audit_copy_token: String.t(),
          request_id: String.t()
        }

  defstruct [
    :audit_copy_token,
    :request_id
  ]

  @impl true
  def cast(generic_map) do
    %__MODULE__{
      audit_copy_token: generic_map["audit_copy_token"],
      request_id: generic_map["request_id"]
    }
  end
end
