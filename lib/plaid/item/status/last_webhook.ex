defmodule Plaid.Item.Status.LastWebhook do
  @moduledoc """
  [Plaid item status last webhook information.](https://plaid.com/docs/api/items/#item-get-response-last-webhookhttps://plaid.com/docs/api/items/#item-get-response-last-webhookhttps://plaid.com/docs/api/items/#item-get-response-last-webhookhttps://plaid.com/docs/api/items/#item-get-response-last-webhookhttps://plaid.com/docs/api/items/#item-get-response-last-webhookhttps://plaid.com/docs/api/items/#item-get-response-last-webhookhttps://plaid.com/docs/api/items/#item-get-response-last-webhookhttps://plaid.com/docs/api/items/#item-get-response-last-webhookhttps://plaid.com/docs/api/items/#item-get-response-last-webhook)
  """

  @behaviour Plaid.Castable

  @type t :: %__MODULE__{
          sent_at: String.t() | nil,
          code_sent: String.t() | nil
        }

  defstruct [
    :sent_at,
    :code_sent
  ]

  @impl true
  def cast(generic_map) do
    %__MODULE__{
      sent_at: generic_map["sent_at"],
      code_sent: generic_map["code_sent"]
    }
  end
end
