defmodule Plaid.Auth.Numbers.BACS do
  @moduledoc """
  [Plaid Numbers BACS schema](https://plaid.com/docs/api/products/#auth-get-response-bacs).
  """

  @behaviour Plaid.Castable

  alias Plaid.Castable

  @type t :: %__MODULE__{
          account: String.t(),
          account_id: String.t(),
          sort_code: String.t()
        }

  defstruct [
    :account,
    :account_id,
    :sort_code
  ]

  @impl Castable
  def cast(generic_map) do
    %__MODULE__{
      account: generic_map["account"],
      account_id: generic_map["account_id"],
      sort_code: generic_map["sort_code"]
    }
  end
end
