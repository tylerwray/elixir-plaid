defmodule Plaid.WebhooksTest do
  # PlaidJWT: eyJhbGciOiJFUzI1NiIsImtpZCI6IjZjNTUxNmUxLTkyZGMtNDc5ZS1hOGZmLTVhNTE5OTJlMDAwMSIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE2MTQ1Nzg2MTcsInJlcXVlc3RfYm9keV9zaGEyNTYiOiIyM2JhM2IxNzcwMjk0ZWVlYWJhM2JmZjc1NTdjNjJlZDZkNmU4MzMzYjZkMmFmZjcyNDIxMWI0N2FkYjVhYWYyIn0.TClT2hrFCjlQSc3WbQ0GpBdwjP9InvTXaMfDYbtFJTlKXua_3tejuuHm4NzYQtCV-lXJ4fub3kLoQFkfi234_Q
  # @webhook_body ~s<{\n  \"error\": null,\n  \"item_id\": \"lvMEnMo5m9ivMdZeemZVtJP8zGXVJDiLPKkEp\",\n  \"new_transactions\": 0,\n  \"webhook_code\": \"DEFAULT_UPDATE\",\n  \"webhook_type\": \"TRANSACTIONS\"\n}>
  use ExUnit.Case, async: true

  alias Plug.Conn

  @kid "c44a8d01-440a-425d-9801-97da26b53a7b"

  # This JWK was generated with JOSE.JWS.generate_key/1
  @json_web_key %{
    "alg" => "ES256",
    "crv" => "P-256",
    "d" => "csr36_se-89-CKdY4nGnbRXNWVntBY03bmMQXSQ3yOg",
    "kty" => "EC",
    "use" => "sig",
    "x" => "bGe_0GV8Kf1kiD9dP9d02h3KmgKe3YndLIyljFpY-Hw",
    "y" => "a-x6gUbGHWX4rK9233n-4FU6rzkwBhUV_AJSdOuOMIs"
  }

  def create_jwt(raw_body) do
    iat = DateTime.to_unix(DateTime.utc_now())

    request_body_sha256 =
      :sha256
      |> :crypto.hash(raw_body)
      |> Base.encode16(padding: false, case: :lower)

    signer = Joken.Signer.create("ES256", @json_web_key, %{"kid" => @kid})

    {:ok, jwt} =
      %{}
      |> Map.put("iat", iat)
      |> Map.put("request_body_sha256", request_body_sha256)
      |> Joken.Signer.sign(signer)

    jwt
  end

  setup do
    bypass = Bypass.open()
    api_host = "http://localhost:#{bypass.port}/"
    {:ok, bypass: bypass, api_host: api_host}
  end

  test "verify_and_construct/2 errors when JWT header algorithm is not ES256" do
    signer = Joken.Signer.create("HS256", "secret")
    {:ok, jwt, _} = Joken.encode_and_sign(%{}, signer)

    {:error, :invalid_algorithm} =
      Plaid.Webhooks.verify_and_construct(jwt, "{}", client_id: "abc", secret: "123")
  end

  test "verify_and_construct/2 verifies the webhook is valid and returns the constructed struct",
       %{
         bypass: bypass,
         api_host: api_host
       } do
    Bypass.expect_once(bypass, "POST", "/webhook_verification_key/get", fn conn ->
      now = DateTime.to_unix(DateTime.utc_now())

      Conn.resp(conn, 200, ~s<{
        "key": {
          "alg": "ES256",
          "created_at": #{now},
          "crv": "P-256",
          "expired_at": null,
          "kid": "#{@kid}",
          "kty": "EC",
          "use": "sig",
          "x": "bGe_0GV8Kf1kiD9dP9d02h3KmgKe3YndLIyljFpY-Hw",
          "y": "a-x6gUbGHWX4rK9233n-4FU6rzkwBhUV_AJSdOuOMIs"
        },
        "request_id": "RZ6Omi1bzzwDaLo"
      }>)
    end)

    raw_body =
      ~s<{"webhook_type": "ITEM", "webhook_code": "ERROR", "item_id": "wz666MBjYWTp2PDzzggYhM6oWWmBb", "error": { "display_message": null, "error_code": "ITEM_LOGIN_REQUIRED", "error_message": "the login details of this item have changed (credentials, MFA, or required user action) and a user login is required to update this information. use Link's update mode to restore the item to a good state", "error_type": "ITEM_ERROR", "status": 400}}>

    jwt = create_jwt(raw_body)

    {:ok,
     %Plaid.Webhooks.ItemError{
       webhook_type: "ITEM",
       webhook_code: "ERROR",
       item_id: "wz666MBjYWTp2PDzzggYhM6oWWmBb",
       error: %Plaid.Error{
         display_message: nil,
         error_code: "ITEM_LOGIN_REQUIRED",
         error_message:
           "the login details of this item have changed (credentials, MFA, or required user action) and a user login is required to update this information. use Link's update mode to restore the item to a good state",
         error_type: "ITEM_ERROR",
         status: 400
       }
     }} =
      Plaid.Webhooks.verify_and_construct(jwt, raw_body,
        client_id: "abc",
        secret: "123",
        test_api_host: api_host
      )
  end
end
