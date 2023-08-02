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

  defmodule ExchangePublicTokenResponse do
    @moduledoc """
    [Plaid API /item/public_token/exchange response schema.](https://plaid.com/docs/api/tokens/#itempublic_tokenexchange)
    """

    @behaviour Castable

    @type t :: %__MODULE__{
            access_token: String.t(),
            item_id: String.t(),
            request_id: String.t()
          }

    defstruct [
      :access_token,
      :item_id,
      :request_id
    ]

    @impl true
    def cast(generic_map) do
      %__MODULE__{
        access_token: generic_map["access_token"],
        item_id: generic_map["item_id"],
        request_id: generic_map["request_id"]
      }
    end
  end

  @doc """
  Exchange a public token for an access token.

  Does a `POST /item/public_token/exchange` call which exchanges a public token
  for an access token.

  ## Params

  * `public_token` - Your public_token, obtained from the Link `onSuccess` callback
  or `POST /sandbox/item/public_token/create.`

  ## Examples

      Item.exchange_public_token(
        "public-prod-123xxx",
        client_id: "123",
        secret: "abc"
      )
      {:ok, %Item.ExchangePublicTokenResponse{}}

  """
  @spec exchange_public_token(String.t(), Plaid.config()) ::
          {:ok, ExchangePublicTokenResponse.t()} | {:error, Plaid.Error.t()}
  def exchange_public_token(public_token, config) do
    Plaid.Client.call(
      "/item/public_token/exchange",
      %{public_token: public_token},
      ExchangePublicTokenResponse,
      config
    )
  end

  defmodule InvalidateAccessTokenResponse do
    @moduledoc """
    [Plaid API /item/access_token/invalidate response schema.](https://plaid.com/docs/api/tokens/#itemaccess_tokeninvalidate)
    """

    @behaviour Castable

    @type t :: %__MODULE__{
            new_access_token: String.t(),
            request_id: String.t()
          }

    defstruct [
      :new_access_token,
      :request_id
    ]

    @impl true
    def cast(generic_map) do
      %__MODULE__{
        new_access_token: generic_map["new_access_token"],
        request_id: generic_map["request_id"]
      }
    end
  end

  @doc """
  Invalidate an access token.

  Does a `POST /item/access_token/invalidate` call which rotates an access token
  for an item. Immediately invalidating it and returning a new access token.

  ## Params

  * `access_token` - The access token associated with the Item data is being requested for.

  ## Examples

      Item.invalidate_access_token(
        "access-prod-123xxx",
        client_id: "123",
        secret: "abc"
      )
      {:ok, %Item.InvalidateAccessTokenResponse{}}

  """
  @spec invalidate_access_token(String.t(), Plaid.config()) ::
          {:ok, InvalidateAccessTokenResponse.t()} | {:error, Plaid.Error.t()}
  def invalidate_access_token(access_token, config) do
    Plaid.Client.call(
      "/item/access_token/invalidate",
      %{access_token: access_token},
      InvalidateAccessTokenResponse,
      config
    )
  end
end
