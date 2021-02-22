defmodule Plaid.Item do
  @moduledoc """
  [Plaid Item API](https://plaid.com/docs/api/items/#itemget) calls and schema.
  """

  @behaviour Plaid.Castable

  alias Plaid.Castable
  alias Plaid.Item.{GetResponse, UpdateWebhookResponse}

  @type t :: %__MODULE__{
          available_products: [String.t()],
          billed_products: [String.t()],
          consent_expiration_time: String.t() | nil,
          error: Plaid.Error.t() | nil,
          has_perpetual_otp: boolean(),
          institution_id: String.t() | nil,
          item_id: String.t(),
          update_type: String.t(),
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
    :update_type,
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
      update_type: generic_map["update_type"],
      webhook: generic_map["webhook"]
    }
  end

  @doc """
  Get information about an item.

  Does a `POST /item/get` call which returns information about an item and
  its status.

  ## Params

  * `access_token` - The access token associated with the item.

  ## Examples

      Item.get("access-prod-123xxx", client_id: "123", secret: "abc")
      {:ok, %Item.GetResponse{}}

  """
  @spec get(String.t(), Plaid.config()) :: {:ok, GetResponse.t()} | {:error, Plaid.Error.t()}
  def get(access_token, config) do
    Plaid.Client.call("/item/get", %{access_token: access_token}, GetResponse, config)
  end

  @doc """
  Removes an item.

  Does a `POST /item/remove` call to remove an item.

  ## Params

  * `access_token` - The access token associated with the item.

  ## Examples

      Item.remove("access-prod-123xxx", client_id: "123", secret: "abc")
      {:ok, %Plaid.SimpleResponse{}}

  """
  @spec remove(String.t(), Plaid.config()) ::
          {:ok, Plaid.SimpleResponse.t()} | {:error, Plaid.Error.t()}
  def remove(access_token, config) do
    Plaid.Client.call("/item/remove", %{access_token: access_token}, Plaid.SimpleResponse, config)
  end

  @doc """
  Update a webhook for an access_token.

  Does a `POST /item/webhook/update` call which is used to update webhook
  for a particular access_token. 

  ## Params

  * `access_token` - The access token associated with the item.
  * `webhook` - The new webhook URL.

  ## Examples

      Item.update_webhook(
        "access-prod-123xxx",
        "https://plaid.com/fake/webhook",
        client_id: "123",
        secret: "abc"
      )
      {:ok, %Plaid.UpdateWebhookResponse{}}

  """
  @spec update_webhook(String.t(), String.t(), Plaid.config()) ::
          {:ok, UpdateWebhookResponse.t()} | {:error, Plaid.Error.t()}
  def update_webhook(access_token, webhook, config) do
    Plaid.Client.call(
      "/item/webhook/update",
      %{access_token: access_token, webhook: webhook},
      UpdateWebhookResponse,
      config
    )
  end
end
