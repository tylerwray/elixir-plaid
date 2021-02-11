defmodule Plaid.AssetReport.AuditCopyResponse do
  @moduledoc """
  [Plaid Asset Report create audit copy response schema](https://plaid.com/docs/api/products/#asset_reportaudit_copycreate)
  """

  @type t :: %__MODULE__{
          audit_copy_token: String.t(),
          request_id: String.t()
        }

  defstruct [
    :audit_copy_token,
    :request_id
  ]
end
