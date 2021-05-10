defmodule Plaid.SandboxTest do
  use ExUnit.Case, async: true

  alias Plug.Conn

  setup do
    bypass = Bypass.open()
    api_host = "http://localhost:#{bypass.port}/"
    {:ok, bypass: bypass, api_host: api_host}
  end

  test "/sandbox/public_token/create", %{bypass: bypass, api_host: api_host} do
    Bypass.expect_once(bypass, "POST", "/sandbox/public_token/create", fn conn ->
      Conn.resp(conn, 200, ~s<{
        "public_token": "public-sandbox-b0e2c4ee-a763-4df5-bfe9-46a46bce993d",
        "request_id": "Aim3b"
      }>)
    end)

    {:ok,
     %Plaid.Sandbox.CreatePublicTokenResponse{
       public_token: "public-sandbox-b0e2c4ee-a763-4df5-bfe9-46a46bce993d",
       request_id: "Aim3b"
     }} =
      Plaid.Sandbox.create_public_token(
        "ins_1",
        ["assets", "auth", "balance"],
        %{
          webhook: "https://webhook.example.com/webhook",
          override_username: "user_is_good",
          override_password: "pass_is_good",
          transactions: %Plaid.Sandbox.TransactionsOptions{
            start_date: "2010-01-01",
            end_date: "2020-01-01"
          }
        },
        test_api_host: api_host,
        client_id: "123",
        secret: "abc"
      )
  end

  test "/sandbox/public_token/create without options", %{bypass: bypass, api_host: api_host} do
    Bypass.expect_once(bypass, "POST", "/sandbox/public_token/create", fn conn ->
      Conn.resp(conn, 200, ~s<{
        "public_token": "public-sandbox-b0e2c4ee-a763-4df5-bfe9-46a46bce993d",
        "request_id": "Aim3b"
      }>)
    end)

    {:ok,
     %Plaid.Sandbox.CreatePublicTokenResponse{
       public_token: "public-sandbox-b0e2c4ee-a763-4df5-bfe9-46a46bce993d",
       request_id: "Aim3b"
     }} =
      Plaid.Sandbox.create_public_token(
        "ins_1",
        ["assets", "auth", "balance"],
        test_api_host: api_host,
        client_id: "123",
        secret: "abc"
      )
  end

  test "/sandbox/item/reset_login", %{bypass: bypass, api_host: api_host} do
    Bypass.expect_once(bypass, "POST", "/sandbox/item/reset_login", fn conn ->
      Conn.resp(conn, 200, ~s<{
        "reset_login": true,
        "request_id": "m8MDnv9okwxFNBV"
      }>)
    end)

    {:ok,
     %Plaid.Sandbox.ResetItemLoginResponse{
       reset_login: true,
       request_id: "m8MDnv9okwxFNBV"
     }} =
      Plaid.Sandbox.reset_item_login(
        "access-prod-123xxx",
        test_api_host: api_host,
        client_id: "123",
        secret: "abc"
      )
  end

  test "/sandbox/item/set_verification_status", %{bypass: bypass, api_host: api_host} do
    Bypass.expect_once(bypass, "POST", "/sandbox/item/set_verification_status", fn conn ->
      Conn.resp(conn, 200, ~s<{
        "request_id": "1vwmF5TBQwiqfwP"
      }>)
    end)

    {:ok,
     %Plaid.SimpleResponse{
       request_id: "1vwmF5TBQwiqfwP"
     }} =
      Plaid.Sandbox.set_item_verification_status(
        "access-prod-123xxx",
        "39flxk4ek2xs",
        "verification_expired",
        test_api_host: api_host,
        client_id: "123",
        secret: "abc"
      )
  end

  test "/sandbox/item/fire_webhook", %{bypass: bypass, api_host: api_host} do
    Bypass.expect_once(bypass, "POST", "/sandbox/item/fire_webhook", fn conn ->
      Conn.resp(conn, 200, ~s<{
        "webhook_fired": true,
        "request_id": "1vwmF5TBQwiqfwP"
      }>)
    end)

    {:ok,
     %Plaid.Sandbox.FireItemWebhookResponse{
       webhook_fired: true,
       request_id: "1vwmF5TBQwiqfwP"
     }} =
      Plaid.Sandbox.fire_item_webhook(
        "access-prod-123xxx",
        "DEFAULT_UPDATE",
        test_api_host: api_host,
        client_id: "123",
        secret: "abc"
      )
  end

  test "/sandbox/bank_transfer/simulate", %{bypass: bypass, api_host: api_host} do
    Bypass.expect_once(bypass, "POST", "/sandbox/bank_transfer/simulate", fn conn ->
      Conn.resp(conn, 200, ~s<{
        "request_id": "1vwmF5TBQwiqfwP"
      }>)
    end)

    {:ok,
     %Plaid.SimpleResponse{
       request_id: "1vwmF5TBQwiqfwP"
     }} =
      Plaid.Sandbox.simulate_bank_transfer(
        "bt_123xxx",
        "failed",
        %{
          failure_reason: %{
            ach_return_code: "R01",
            description: "Failed for unknown reason"
          }
        },
        test_api_host: api_host,
        client_id: "123",
        secret: "abc"
      )
  end

  test "/sandbox/bank_transfer/simulate without options", %{bypass: bypass, api_host: api_host} do
    Bypass.expect_once(bypass, "POST", "/sandbox/bank_transfer/simulate", fn conn ->
      Conn.resp(conn, 200, ~s<{
        "request_id": "1vwmF5TBQwiqfwP"
      }>)
    end)

    {:ok,
     %Plaid.SimpleResponse{
       request_id: "1vwmF5TBQwiqfwP"
     }} =
      Plaid.Sandbox.simulate_bank_transfer(
        "bt_123xxx",
        "failed",
        test_api_host: api_host,
        client_id: "123",
        secret: "abc"
      )
  end

  test "/sandbox/bank_transfer/fire_webhook", %{bypass: bypass, api_host: api_host} do
    Bypass.expect_once(bypass, "POST", "/sandbox/bank_transfer/fire_webhook", fn conn ->
      Conn.resp(conn, 200, ~s<{
        "request_id": "1vwmF5TBQwiqfwP"
      }>)
    end)

    {:ok,
     %Plaid.SimpleResponse{
       request_id: "1vwmF5TBQwiqfwP"
     }} =
      Plaid.Sandbox.fire_bank_transfer_webhook(
        "https://example.com/webhook",
        test_api_host: api_host,
        client_id: "123",
        secret: "abc"
      )
  end

  test "/sandbox/processor_token/create", %{bypass: bypass, api_host: api_host} do
    Bypass.expect_once(bypass, "POST", "/sandbox/processor_token/create", fn conn ->
      Conn.resp(conn, 200, ~s<{
        "processor_token": "processor-sandbox-b0e2c4ee-a763-4df5-bfe9-46a46bce993d",
        "request_id": "Aim3b"
      }>)
    end)

    {:ok,
     %Plaid.Sandbox.CreateProcessorTokenResponse{
       processor_token: "processor-sandbox-b0e2c4ee-a763-4df5-bfe9-46a46bce993d",
       request_id: "Aim3b"
     }} =
      Plaid.Sandbox.create_processor_token(
        "ins_1",
        %{override_username: "user_is_good", override_password: "pass_is_good"},
        test_api_host: api_host,
        client_id: "123",
        secret: "abc"
      )
  end

  test "/sandbox/processor_token/create without options", %{bypass: bypass, api_host: api_host} do
    Bypass.expect_once(bypass, "POST", "/sandbox/processor_token/create", fn conn ->
      Conn.resp(conn, 200, ~s<{
        "processor_token": "processor-sandbox-b0e2c4ee-a763-4df5-bfe9-46a46bce993d",
        "request_id": "Aim3b"
      }>)
    end)

    {:ok,
     %Plaid.Sandbox.CreateProcessorTokenResponse{
       processor_token: "processor-sandbox-b0e2c4ee-a763-4df5-bfe9-46a46bce993d",
       request_id: "Aim3b"
     }} =
      Plaid.Sandbox.create_processor_token(
        "ins_1",
        test_api_host: api_host,
        client_id: "123",
        secret: "abc"
      )
  end
end
