defmodule Plaid.ProcessorTest do
  use ExUnit.Case, async: true

  alias Plug.Conn

  setup do
    bypass = Bypass.open()
    api_host = "http://localhost:#{bypass.port}/"
    {:ok, bypass: bypass, api_host: api_host}
  end

  test "/processor/token/create", %{bypass: bypass, api_host: api_host} do
    Bypass.expect_once(bypass, "POST", "/processor/token/create", fn conn ->
      Conn.resp(conn, 200, ~s<{
        "processor_token": "processor-sandbox-0asd1-a92nc",
        "request_id": "xrQNYZ7Zoh6R7gV"
      }>)
    end)

    {:ok,
     %Plaid.Processor.CreateTokenResponse{
       processor_token: "processor-sandbox-0asd1-a92nc",
       request_id: "xrQNYZ7Zoh6R7gV"
     }} =
      Plaid.Processor.create_token(
        "access-prod-123xxx",
        "blgjekslk3k2l2kkbvjkds",
        "galileo",
        test_api_host: api_host,
        client_id: "123",
        secret: "abc"
      )
  end

  test "/processor/stripe/bank_account_token/create", %{bypass: bypass, api_host: api_host} do
    Bypass.expect_once(bypass, "POST", "/processor/stripe/bank_account_token/create", fn conn ->
      Conn.resp(conn, 200, ~s<{
        "stripe_bank_account_token": "btok_5oEetfLzPklE1fwJZ7SG",
        "request_id": "xrQNYZ7Zoh6R7gV"
      }>)
    end)

    {:ok,
     %Plaid.Processor.CreateStripeBankAccountTokenResponse{
       stripe_bank_account_token: "btok_5oEetfLzPklE1fwJZ7SG",
       request_id: "xrQNYZ7Zoh6R7gV"
     }} =
      Plaid.Processor.create_stripe_bank_account_token(
        "access-prod-123xxx",
        "blgjekslk3k2l2kkbvjkds",
        test_api_host: api_host,
        client_id: "123",
        secret: "abc"
      )
  end
end
