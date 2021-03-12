defmodule Plaid.LinkToken.DepositSwitch do
  @moduledoc """
  [Plaid link token deposit switch argument.](https://plaid.com/docs/api/tokens/#link-token-create-request-deposit-switch)
  """

  @type t :: %__MODULE__{
          deposit_switch_id: String.t()
        }

  @enforce_keys [:deposit_switch_id]

  @derive Jason.Encoder
  defstruct [:deposit_switch_id]
end
