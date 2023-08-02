defmodule Plaid.Identity.Match.Item do
  @moduledoc """
  [Plaid Identity Match Item schema.](https://plaid.com/docs/api/products/identity/#identity-match-response-item).
  """

  @behaviour Plaid.Castable

  @type t :: %__MODULE__{
          item_id: String.t(),
          institution_id: String.t() | nil,
          webhook: String.t() | nil,
          error: Plaid.Error.t() | nil,
          available_products: [String.t()] | nil,
          billed_products: [String.t()] | nil,
          products: [String.t()] | nil,
          consented_products: [String.t()] | nil,
          consent_expiration_time: String.t() | nil,
          update_type: String.t() | nil
        }

  defstruct [
    :item_id,
    :institution_id,
    :webhook,
    :error,
    :available_products,
    :billed_products,
    :products,
    :consented_products,
    :consent_expiration_time,
    :update_type
  ]

  @impl true
  def cast(map) do
    %__MODULE__{
      item_id: map["item_id"],
      institution_id: map["institution_id"],
      webhook: map["webhook"],
      error: Plaid.Castable.cast(Plaid.Error, map["error"]),
      available_products: map["available_products"],
      billed_products: map["billed_products"],
      products: map["products"],
      consented_products: map["consented_products"],
      consent_expiration_time: map["consent_expiration_time"],
      update_type: map["update_type"]
    }
  end
end
