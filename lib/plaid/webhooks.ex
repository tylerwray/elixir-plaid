defmodule Plaid.Webhooks do
  @moduledoc """
  Verify webhooks from plaid and construct the raw body into structs
  """

  alias Plaid.Castable

  defmodule ItemError do
    @moduledoc """
    [Plaid webhooks ITEM_ERROR schema](https://plaid.com/docs/api/webhooks/#item-error)
    """

    @behaviour Castable

    @type t :: %__MODULE__{
            webhook_type: String.t(),
            webhook_code: String.t(),
            item_id: String.t(),
            error: Plaid.Error.t()
          }

    defstruct [:webhook_type, :webhook_code, :item_id, :error]

    @impl true
    def cast(generic_map) do
      %__MODULE__{
        webhook_type: generic_map["webhook_type"],
        webhook_code: generic_map["webhook_code"],
        item_id: generic_map["item_id"],
        error: Castable.cast(Plaid.Error, generic_map["error"])
      }
    end
  end

  @doc """
  Verify that a webhook is actually from plaid, constructing the raw body into an event struct.

  Adheres to the guidelines outlined in [this guide](https://plaid.com/docs/api/webhook-verification/) 
  from plaid to verify webhooks. 

  Also constructs the `raw_body` into an event struct.

  ## Examples

      verify_and_construct(
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c",
        ~s({"webhook_type": "ITEM", "webhook_code": "ERROR"}),
        client_id: "abc",
        secret: "123"
      )
      {:ok, %Plaid.Webhooks.ItemError{}}

  """
  @spec verify_and_construct(String.t(), String.t(), Plaid.Config.t()) ::
          {:ok, struct()} | {:error, any()}
  def verify_and_construct(jwt, raw_body, config) do
    token_config = %{
      "iat" => %Joken.Claim{
        validate: fn issued_at, _, _ ->
          age = DateTime.to_unix(DateTime.utc_now()) - issued_at
          five_minutes = 5 * 60

          age <= five_minutes
        end
      }
    }

    with {:ok, %{"alg" => "ES256", "kid" => kid}} <- Joken.peek_header(jwt),
         {:ok, %{key: key}} <- get_verification_key(kid, config),
         signer = Joken.Signer.create("ES256", key),
         {:ok, %{"request_body_sha256" => claimed_body_hash}} <-
           Joken.verify_and_validate(token_config, jwt, signer),
         true <- SecureCompare.compare(body_hash(raw_body), claimed_body_hash),
         {:ok, %{"webhook_type" => type, "webhook_code" => code} = body} <- Jason.decode(raw_body) do
      {:ok, Plaid.Castable.cast(struct_module(type, code), body)}
    else
      {:ok, %{"alg" => _alg}} -> {:error, :invalid_algorithm}
    end
  end

  @spec body_hash(String.t()) :: String.t()
  defp body_hash(raw_body) do
    :sha256
    |> :crypto.hash(raw_body)
    |> Base.encode16(padding: false, case: :lower)
  end

  defmodule GetVerificationKeyResponse do
    @moduledoc false
    @behaviour Castable

    @type t :: %__MODULE__{
            key: map(),
            request_id: String.t()
          }

    defstruct [:key, :request_id]

    @impl true
    def cast(generic_map) do
      %__MODULE__{
        # Keeping key as a string-keyed map because
        # that's what Joken.Signer.create/3 requires.
        key: generic_map["key"],
        request_id: generic_map["key"]
      }
    end
  end

  @spec get_verification_key(String.t(), Plaid.config()) ::
          {:ok, GetVerificationKeyResponse.t()} | {:error, Plaid.Error.t()}
  defp get_verification_key(key_id, config) do
    Plaid.Client.call(
      "/webhook_verification_key/get",
      %{key_id: key_id},
      GetVerificationKeyResponse,
      config
    )
  end

  @spec struct_module(String.t(), String.t()) :: module()
  defp struct_module("ITEM", "ERROR"), do: ItemError
end
