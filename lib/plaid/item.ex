defmodule Plaid.Item do
  @moduledoc """
  [Plaid Item API](https://plaid.com/docs/api/items/#itemget) schema.
  """

  @type t :: %__MODULE__{
          available_products: list(String.t()),
          billed_products: list(String.t()),
          consent_expiration_time: String.t() | nil,
          error: Plaid.Error.t() | nil,
          institution_id: String.t() | nil,
          item_id: String.t(),
          webhook: String.t() | nil
        }

  defstruct [
    :available_products,
    :billed_products,
    :consent_expiration_time,
    :error,
    :institution_id,
    :item_id,
    :webhook
  ]
end
