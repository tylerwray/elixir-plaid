defmodule Plaid.Auth.Numbers.EFT do
  @moduledoc """
  [Plaid Numbers EFT schema](https://plaid.com/docs/api/products/#auth-get-response-eft).
  """

  @behaviour Plaid.Castable

  alias Plaid.Castable

  @type t :: %__MODULE__{
          account: String.t(),
          account_id: String.t(),
          institution: String.t(),
          branch: String.t()
        }

  defstruct [
    :account,
    :account_id,
    :institution,
    :branch
  ]

  @impl Castable
  def cast(generic_map) do
    %__MODULE__{
      account: generic_map["account"],
      account_id: generic_map["account_id"],
      institution: generic_map["institution"],
      branch: generic_map["branch"]
    }
  end
end
