defmodule Plaid.Item do
  @moduledoc """
  [Plaid Item API](https://plaid.com/docs/api/items/#itemget) calls and schema.
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

  defmodule GetResponse do
    @moduledoc """
    [Plaid API /item/get response schema.](https://plaid.com/docs/api/items/#itemget)
    """

    @behaviour Castable

    alias Plaid.Castable
    alias Plaid.Item
    alias Plaid.Item.Status

    @type t :: %__MODULE__{
            item: Item.t(),
            status: Status.t() | nil,
            request_id: String.t(),
            access_token: String.t() | nil
          }

    defstruct [
      :item,
      :status,
      :request_id,
      :access_token
    ]

    @impl true
    def cast(generic_map) do
      %__MODULE__{
        item: Castable.cast(Item, generic_map["item"]),
        status: Castable.cast(Status, generic_map["status"]),
        request_id: generic_map["request_id"],
        access_token: generic_map["access_token"]
      }
    end
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

  defmodule UpdateWebhookResponse do
    @moduledoc """
    [Plaid API /item/webhook/update response schema.](https://plaid.com/docs/api/items/#itemwebhookupdate)
    """

    @behaviour Castable

    alias Plaid.Item

    @type t :: %__MODULE__{
            item: Item.t(),
            request_id: String.t()
          }

    defstruct [
      :item,
      :request_id
    ]

    @impl true
    def cast(generic_map) do
      %__MODULE__{
        item: Castable.cast(Item, generic_map["item"]),
        request_id: generic_map["request_id"]
      }
    end
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
      {:ok, %Item.UpdateWebhookResponse{}}

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
