defmodule Plaid.Processor.Numbers do
  @moduledoc """
  [Plaid Processor Numbers schema](https://plaid.com/docs/api/processors/#processorauthget).
  """

  @behaviour Plaid.Castable

  alias Plaid.Auth.Numbers.{ACH, BACS, EFT, International}
  alias Plaid.Castable

  @type t :: %__MODULE__{
          ach: ACH.t(),
          eft: EFT.t(),
          international: International.t(),
          bacs: BACS.t()
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
      ach: Castable.cast(ACH, generic_map["ach"]),
      eft: Castable.cast(EFT, generic_map["eft"]),
      international: Castable.cast(International, generic_map["international"]),
      bacs: Castable.cast(BACS, generic_map["bacs"])
    }
  end
end
