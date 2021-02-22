defmodule Plaid.Item.Status do
  @moduledoc """
  [Plaid item status schema.](https://plaid.com/docs/api/items/#item-get-response-status)
  """

  @behaviour Plaid.Castable

  alias Plaid.Castable

  alias Plaid.Item.Status.{
    Investments,
    LastWebhook,
    Transactions
  }

  @type t :: %__MODULE__{
          investments: Investments.t() | nil,
          transactions: Transactions.t() | nil,
          last_webhook: LastWebhook.t() | nil
        }

  defstruct [
    :investments,
    :transactions,
    :last_webhook
  ]

  @impl true
  def cast(generic_map) do
    %__MODULE__{
      investments: Castable.cast(Investments, generic_map["investments"]),
      transactions: Castable.cast(Transactions, generic_map["transactions"]),
      last_webhook: Castable.cast(LastWebhook, generic_map["last_webhook"])
    }
  end
end
