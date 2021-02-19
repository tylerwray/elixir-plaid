defmodule Plaid.Item do
  @moduledoc """
  [Plaid Item API](https://plaid.com/docs/api/items/#itemget) schema.
  """

  @behaviour Plaid.Castable

  alias Plaid.Castable

  @type t :: %__MODULE__{
          available_products: [String.t()],
          billed_products: [String.t()],
          consent_expiration_time: String.t() | nil,
          error: Plaid.Error.t() | nil,
          has_perpetual_otp: boolean(),
          institution_id: String.t() | nil,
          item_id: String.t(),
          webhook: String.t() | nil
        }

  defstruct [
    :available_products,
    :billed_products,
    :consent_expiration_time,
    :has_perpetual_otp,
    :error,
    :institution_id,
    :item_id,
    :webhook
  ]

  @impl true
  def cast(generic_map) do
    %__MODULE__{
      available_products: generic_map["available_products"],
      billed_products: generic_map["billed_products"],
      consent_expiration_time: generic_map["consent_expiration_time"],
      error: Castable.cast(Plaid.Error, generic_map["error"]),
      has_perpetual_otp: generic_map["has_perpetual_otp"],
      institution_id: generic_map["institution_id"],
      item_id: generic_map["item_id"],
      webhook: generic_map["webhook"]
    }
  end
end
