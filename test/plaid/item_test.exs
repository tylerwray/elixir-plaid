defmodule Plaid.ItemTest do
  use ExUnit.Case
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
end
