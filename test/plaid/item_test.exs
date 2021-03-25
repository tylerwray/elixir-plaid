defmodule Plaid.ItemTest do
  use ExUnit.Case, async: true

  alias Plug.Conn

  setup do
    bypass = Bypass.open()
    api_host = "http://localhost:#{bypass.port}/"
    {:ok, bypass: bypass, api_host: api_host}
  end

  test "/item/get", %{bypass: bypass, api_host: api_host} do
    Bypass.expect_once(bypass, "POST", "/item/get", fn conn ->
      Conn.resp(conn, 200, ~s<{
        "item": {
          "available_products": [
            "balance",
            "auth"
          ],
          "billed_products": [
            "identity",
            "transactions"
          ],
          "error": null,
          "institution_id": "ins_109508",
          "item_id": "Ed6bjNrDLJfGvZWwnkQlfxwoNz54B5C97ejBr",
          "update_type": "background",
          "webhook": "https://plaid.com/example/hook",
          "consent_expiration_time": null
        },
        "status": {
          "transactions": {
            "last_successful_update": "2019-02-15T15:52:39.000Z",
            "last_failed_update": "2019-01-22T04:32:00.000Z"
          },
          "last_webhook": {
            "sent_at": "2019-02-15T15:53:00.000Z",
            "code_sent": "DEFAULT_UPDATE"
          }
        },
        "request_id": "m8MDnv9okwxFNBV"
      }>)
    end)

    {:ok,
     %Plaid.Item.GetResponse{
       item: %Plaid.Item{
         available_products: [
           "balance",
           "auth"
         ],
         billed_products: [
           "identity",
           "transactions"
         ],
         error: nil,
         institution_id: "ins_109508",
         item_id: "Ed6bjNrDLJfGvZWwnkQlfxwoNz54B5C97ejBr",
         update_type: "background",
         webhook: "https://plaid.com/example/hook",
         consent_expiration_time: nil
       },
       status: %Plaid.Item.Status{
         transactions: %Plaid.Item.Status.Transactions{
           last_successful_update: "2019-02-15T15:52:39.000Z",
           last_failed_update: "2019-01-22T04:32:00.000Z"
         },
         last_webhook: %Plaid.Item.Status.LastWebhook{
           sent_at: "2019-02-15T15:53:00.000Z",
           code_sent: "DEFAULT_UPDATE"
         }
       },
       request_id: "m8MDnv9okwxFNBV"
     }} =
      Plaid.Item.get(
        "access-prod-123xxx",
        test_api_host: api_host,
        client_id: "123",
        secret: "abc"
      )
  end

  test "/item/remove", %{bypass: bypass, api_host: api_host} do
    Bypass.expect_once(bypass, "POST", "/item/remove", fn conn ->
      Conn.resp(conn, 200, ~s<{
        "request_id": "m8MDnv9okwxFNBV"
      }>)
    end)

    {:ok, %Plaid.SimpleResponse{request_id: "m8MDnv9okwxFNBV"}} =
      Plaid.Item.remove(
        "access-prod-123xxx",
        test_api_host: api_host,
        client_id: "123",
        secret: "abc"
      )
  end

  test "/item/webhook/update", %{bypass: bypass, api_host: api_host} do
    Bypass.expect_once(bypass, "POST", "/item/webhook/update", fn conn ->
      Conn.resp(conn, 200, ~s<{
        "item": {
          "available_products": [
            "balance",
            "identity",
            "payment_initiation",
            "transactions"
          ],
          "billed_products": [
            "assets",
            "auth"
          ],
          "consent_expiration_time": null,
          "error": null,
          "institution_id": "ins_117650",
          "item_id": "DWVAAPWq4RHGlEaNyGKRTAnPLaEmo8Cvq7na6",
          "update_type": "background",
          "webhook": "https://www.genericwebhookurl.com/webhook"
        },
        "request_id": "vYK11LNTfRoAMbj"
      }>)
    end)

    {:ok,
     %Plaid.Item.UpdateWebhookResponse{
       item: %Plaid.Item{
         available_products: [
           "balance",
           "identity",
           "payment_initiation",
           "transactions"
         ],
         billed_products: [
           "assets",
           "auth"
         ],
         consent_expiration_time: nil,
         error: nil,
         institution_id: "ins_117650",
         item_id: "DWVAAPWq4RHGlEaNyGKRTAnPLaEmo8Cvq7na6",
         update_type: "background",
         webhook: "https://www.genericwebhookurl.com/webhook"
       },
       request_id: "vYK11LNTfRoAMbj"
     }} =
      Plaid.Item.update_webhook(
        "access-prod-123xxx",
        "https://plaid.com/updated/hook",
        test_api_host: api_host,
        client_id: "123",
        secret: "abc"
      )
  end

  test "/item/public_token/exchange", %{bypass: bypass, api_host: api_host} do
    Bypass.expect_once(bypass, "POST", "/item/public_token/exchange", fn conn ->
      Conn.resp(conn, 200, ~s<{
        "access_token": "access-sandbox-de3ce8ef-33f8-452c-a685-8671031fc0f6",
        "item_id": "M5eVJqLnv3tbzdngLDp9FL5OlDNxlNhlE55op",
        "request_id": "Aim3b"
      }>)
    end)

    {:ok,
     %Plaid.Item.ExchangePublicTokenResponse{
       access_token: "access-sandbox-de3ce8ef-33f8-452c-a685-8671031fc0f6",
       item_id: "M5eVJqLnv3tbzdngLDp9FL5OlDNxlNhlE55op",
       request_id: "Aim3b"
     }} =
      Plaid.Item.exchange_public_token(
        "public-prod-123xxx",
        test_api_host: api_host,
        client_id: "123",
        secret: "abc"
      )
  end
end
