defmodule Plaid.Item do
  @moduledoc """
  Plaid Item API schema.
  https://plaid.com/docs/api/items/#itemget
  """

  @type t :: %__MODULE__{
          item_id: String.t(),
          institution_id: String.t() | nil,
          webhook: String.t() | nil,
          error: Plaid.Error.t() | nil,
          available_products: list(String.t()),
          billed_products: list(String.t()),
          consent_expiration_time: String.t() | nil
        }

  defstruct [
    :item_id,
    :institution_id,
    :webhook,
    :error,
    :available_products,
    :billed_products,
    :consent_expiration_time
  ]
end
