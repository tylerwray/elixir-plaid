defmodule Plaid.TransactionsTest do
  use ExUnit.Case, async: true

  alias Plug.Conn

  setup do
    bypass = Bypass.open()
    api_host = "http://localhost:#{bypass.port}/"
    {:ok, bypass: bypass, api_host: api_host}
  end

  test "/transactions/get", %{bypass: bypass, api_host: api_host} do
    Bypass.expect_once(bypass, "POST", "/transactions/get", fn conn ->
      Conn.resp(conn, 200, ~s<{
        "accounts": [
          {
            "account_id": "BxBXxLj1m4HMXBm9WZZmCWVbPjX16EHwv99vp",
            "balances": {
              "available": 110,
              "current": 110,
              "iso_currency_code": "USD",
              "limit": null,
              "unofficial_currency_code": null
            },
            "mask": "0000",
            "name": "Plaid Checking",
            "official_name": "Plaid Gold Standard 0% Interest Checking",
            "subtype": "checking",
            "type": "depository"
          }
        ],
        "transactions": [
          {
            "account_id": "BxBXxLj1m4HMXBm9WZZmCWVbPjX16EHwv99vp",
            "amount": 2307.21,
            "iso_currency_code": "USD",
            "unofficial_currency_code": null,
            "category": [
              "Shops",
              "Computers and Electronics"
            ],
            "category_id": "19013000",
            "date": "2017-01-29",
            "authorized_date": "2017-01-27",
            "location": {
              "address": "300 Post St",
              "city": "San Francisco",
              "region": "CA",
              "postal_code": "94108",
              "country": "US",
              "lat": 40.740352,
              "lon": -74.001761,
              "store_number": "1235"
            },
            "name": "Apple Store",
            "merchant_name": "Apple",
            "payment_meta": {
              "by_order_of": null,
              "payee": null,
              "payer": null,
              "payment_method": null,
              "payment_processor": null,
              "ppd_id": null,
              "reason": null,
              "reference_number": null
            },
            "payment_channel": "in store",
            "pending": false,
            "pending_transaction_id": null,
            "account_owner": null,
            "transaction_id": "lPNjeW1nR6CDn5okmGQ6hEpMo4lLNoSrzqDje",
            "transaction_code": null,
            "transaction_type": "place"
          }
        ],
        "item": {
          "available_products": [
            "balance",
            "identity",
            "investments"
          ],
          "billed_products": [
            "assets",
            "auth",
            "liabilities",
            "transactions"
          ],
          "consent_expiration_time": null,
          "error": null,
          "institution_id": "ins_3",
          "item_id": "eVBnVMp7zdTJLkRNr33Rs6zr7KNJqBFL9DrE6",
          "webhook": "https://www.genericwebhookurl.com/webhook"
        },
        "total_transactions": 1,
        "request_id": "45QSn"
      }>)
    end)

    {:ok,
     %Plaid.Transactions.GetResponse{
       accounts: [
         %Plaid.Account{
           account_id: "BxBXxLj1m4HMXBm9WZZmCWVbPjX16EHwv99vp",
           balances: %Plaid.Account.Balances{
             available: 110,
             current: 110,
             iso_currency_code: "USD",
             limit: nil,
             unofficial_currency_code: nil
           },
           mask: "0000",
           name: "Plaid Checking",
           official_name: "Plaid Gold Standard 0% Interest Checking",
           subtype: "checking",
           type: "depository"
         }
       ],
       transactions: [
         %Plaid.Transactions.Transaction{
           account_id: "BxBXxLj1m4HMXBm9WZZmCWVbPjX16EHwv99vp",
           amount: 2307.21,
           iso_currency_code: "USD",
           unofficial_currency_code: nil,
           category: [
             "Shops",
             "Computers and Electronics"
           ],
           category_id: "19013000",
           date: "2017-01-29",
           authorized_date: "2017-01-27",
           location: %Plaid.Transactions.Transaction.Location{
             address: "300 Post St",
             city: "San Francisco",
             region: "CA",
             postal_code: "94108",
             country: "US",
             lat: 40.740352,
             lon: -74.001761,
             store_number: "1235"
           },
           name: "Apple Store",
           merchant_name: "Apple",
           payment_meta: %Plaid.Transactions.Transaction.PaymentMeta{
             by_order_of: nil,
             payee: nil,
             payer: nil,
             payment_method: nil,
             payment_processor: nil,
             ppd_id: nil,
             reason: nil,
             reference_number: nil
           },
           payment_channel: "in store",
           pending: false,
           pending_transaction_id: nil,
           account_owner: nil,
           transaction_id: "lPNjeW1nR6CDn5okmGQ6hEpMo4lLNoSrzqDje",
           transaction_code: nil,
           transaction_type: "place"
         }
       ],
       item: %Plaid.Item{
         available_products: [
           "balance",
           "identity",
           "investments"
         ],
         billed_products: [
           "assets",
           "auth",
           "liabilities",
           "transactions"
         ],
         consent_expiration_time: nil,
         error: nil,
         institution_id: "ins_3",
         item_id: "eVBnVMp7zdTJLkRNr33Rs6zr7KNJqBFL9DrE6",
         webhook: "https://www.genericwebhookurl.com/webhook"
       },
       total_transactions: 1,
       request_id: "45QSn"
     }} =
      Plaid.Transactions.get(
        "access-prod-123xxx",
        "2021-01-01",
        "2021-01-10",
        %{count: 1, offset: 0, account_ids: []},
        test_api_host: api_host,
        client_id: "123",
        secret: "abc"
      )
  end

  test "/transactions/refresh", %{bypass: bypass, api_host: api_host} do
    Bypass.expect_once(bypass, "POST", "/transactions/refresh", fn conn ->
      Conn.resp(conn, 200, ~s<{"request_id": "1vwmF5TBQwiqfwP"}>)
    end)

    {:ok, %Plaid.SimpleResponse{request_id: "1vwmF5TBQwiqfwP"}} =
      Plaid.Transactions.refresh(
        "access-prod-123xxx",
        test_api_host: api_host,
        client_id: "123",
        secret: "abc"
      )
  end
end
