defmodule Plaid.Auth.Numbers do
  @moduledoc """
  [Plaid Numbers schema](https://plaid.com/docs/api/products/#auth-get-response-numbers).
  """

  @behaviour Plaid.Castable

  alias Plaid.Auth.Numbers.{ACH, BACS, EFT, International}
  alias Plaid.Castable

  @type t :: %__MODULE__{
          ach: [ACH.t()],
          eft: [EFT.t()],
          international: [International.t()],
          bacs: [BACS.t()]
        }

  defstruct [
    :ach,
    :eft,
    :international,
    :bacs
  ]

  @impl true
  def cast(generic_map) do
    %__MODULE__{
      ach: Castable.cast_list(ACH, generic_map["ach"]),
      eft: Castable.cast_list(EFT, generic_map["eft"]),
      international: Castable.cast_list(International, generic_map["international"]),
      bacs: Castable.cast_list(BACS, generic_map["bacs"])
    }
  end
end
