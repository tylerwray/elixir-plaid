defmodule Plaid.LinkTokenTest do
  use ExUnit.Case, async: true

  alias Plug.Conn

  setup do
    bypass = Bypass.open()
    api_host = "http://localhost:#{bypass.port}/"
    {:ok, bypass: bypass, api_host: api_host}
  end

  test "/link/token/create", %{bypass: bypass, api_host: api_host} do
    Bypass.expect_once(bypass, "POST", "/link/token/create", fn conn ->
      Conn.resp(conn, 200, ~s<{
        "link_token": "link-production-840204-193734",
        "expiration": "2020-03-27T12:56:34Z",
        "request_id": "XQVgFigpGHXkb0b"
      }>)
    end)

    {:ok,
     %Plaid.LinkToken.CreateResponse{
       link_token: "link-production-840204-193734",
       expiration: "2020-03-27T12:56:34Z",
       request_id: "XQVgFigpGHXkb0b"
     }} =
      Plaid.LinkToken.create(
        %{
          client_name: "Plaid Test App",
          language: "en",
          country_codes: ["US", "CA"],
          user: %Plaid.LinkToken.User{
            client_user_id: "123-test-user",
            legal_name: "Test User",
            phone_number: "+19995550123",
            phone_number_verified_time: "2020-01-01T00:00:00Z",
            email_address: "test@example.com",
            email_address_verified_time: "2020-01-01T00:00:00Z",
            ssn: "444-33-2222",
            date_of_birth: "1990-01-01"
          },
          products: ["auth", "transactions"],
          webhook: "https://example.com/webhook",
          access_token: "access-prod-123xxx",
          link_customization_name: "vip-user",
          redirect_uri: "https://example.com/redirect",
          android_package_name: "com.service.user",
          account_filters: %{
            depository: %{
              account_subtypes: ["401k", "529"]
            }
          },
          payment_initiation: %Plaid.LinkToken.PaymentInitiation{
            payment_id: "payment-id-sandbox-123xxx"
          },
          deposit_switch: %Plaid.LinkToken.DepositSwitch{
            deposit_switch_id: "deposit-switch-id-sandbox-123xxx"
          }
        },
        test_api_host: api_host,
        client_id: "123",
        secret: "abc"
      )
  end
end
