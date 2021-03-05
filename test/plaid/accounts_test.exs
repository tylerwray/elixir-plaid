defmodule Plaid.AccountsTest do
  use ExUnit.Case, async: true

  alias Plug.Conn

  setup do
    bypass = Bypass.open()
    api_host = "http://localhost:#{bypass.port}/"
    {:ok, bypass: bypass, api_host: api_host}
  end

  test "POST /accounts/get", %{bypass: bypass, api_host: api_host} do
    Bypass.expect_once(bypass, "POST", "/accounts/get", fn conn ->
      Conn.resp(conn, 200, ~s<{
        "accounts": [
          {
            "account_id": "blgvvBlXw3cq5GMPwqB6s6q4dLKB9WcVqGDGo",
            "balances": {
              "available": 100,
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
          },
          {
            "account_id": "6PdjjRP6LmugpBy5NgQvUqpRXMWxzktg3rwrk",
            "balances": {
              "available": null,
              "current": 23631.9805,
              "iso_currency_code": "USD",
              "limit": null,
              "unofficial_currency_code": null
            },
            "mask": "6666",
            "name": "Plaid 401k",
            "official_name": null,
            "subtype": "401k",
            "type": "investment"
          },
          {
            "account_id": "XMBvvyMGQ1UoLbKByoMqH3nXMj84ALSdE5B58",
            "balances": {
              "available": null,
              "current": 65262,
              "iso_currency_code": "USD",
              "limit": null,
              "unofficial_currency_code": null
            },
            "mask": "7777",
            "name": "Plaid Student Loan",
            "official_name": null,
            "subtype": "student",
            "type": "loan"
          }
        ],
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
          "webhook": "https://www.genericwebhookurl.com/webhook"
        },
        "request_id": "bkVE1BHWMAZ9Rnr"
      }>)
    end)

    {:ok,
     %Plaid.Accounts.GetResponse{
       accounts: [
         %Plaid.Accounts.Account{
           account_id: "blgvvBlXw3cq5GMPwqB6s6q4dLKB9WcVqGDGo",
           balances: %Plaid.Accounts.Account.Balances{
             available: 100,
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
         },
         %Plaid.Accounts.Account{
           account_id: "6PdjjRP6LmugpBy5NgQvUqpRXMWxzktg3rwrk",
           balances: %Plaid.Accounts.Account.Balances{
             available: nil,
             current: 23_631.9805,
             iso_currency_code: "USD",
             limit: nil,
             unofficial_currency_code: nil
           },
           mask: "6666",
           name: "Plaid 401k",
           official_name: nil,
           subtype: "401k",
           type: "investment"
         },
         %Plaid.Accounts.Account{
           account_id: "XMBvvyMGQ1UoLbKByoMqH3nXMj84ALSdE5B58",
           balances: %Plaid.Accounts.Account.Balances{
             available: nil,
             current: 65_262,
             iso_currency_code: "USD",
             limit: nil,
             unofficial_currency_code: nil
           },
           mask: "7777",
           name: "Plaid Student Loan",
           official_name: nil,
           subtype: "student",
           type: "loan"
         }
       ],
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
         webhook: "https://www.genericwebhookurl.com/webhook"
       },
       request_id: "bkVE1BHWMAZ9Rnr"
     }} =
      Plaid.Accounts.get("access-prod-123xxx",
        test_api_host: api_host,
        client_id: "123",
        secret: "abc"
      )
  end

  test "POST /accounts/balance/get", %{bypass: bypass, api_host: api_host} do
    Bypass.expect_once(bypass, "POST", "/accounts/balance/get", fn conn ->
      Conn.resp(conn, 200, ~s<{
        "accounts": [
          {
            "account_id": "BxBXxLj1m4HMXBm9WZZmCWVbPjX16EHwv99vp",
            "balances": {
              "available": 100,
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
          },
          {
            "account_id": "dVzbVMLjrxTnLjX4G66XUp5GLklm4oiZy88yK",
            "balances": {
              "available": null,
              "current": 410,
              "iso_currency_code": "USD",
              "limit": 2000,
              "unofficial_currency_code": null
            },
            "mask": "3333",
            "name": "Plaid Credit Card",
            "official_name": "Plaid Diamond 12.5% APR Interest Credit Card",
            "subtype": "credit card",
            "type": "credit"
          },
          {
            "account_id": "Pp1Vpkl9w8sajvK6oEEKtr7vZxBnGpf7LxxLE",
            "balances": {
              "available": null,
              "current": 65262,
              "iso_currency_code": "USD",
              "limit": null,
              "unofficial_currency_code": null
            },
            "mask": "7777",
            "name": "Plaid Student Loan",
            "official_name": null,
            "subtype": "student",
            "type": "loan"
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
        "request_id": "qk5Bxes3gDfv4F2"
      }>)
    end)

    {:ok,
     %Plaid.Accounts.GetResponse{
       accounts: [
         %Plaid.Accounts.Account{
           account_id: "BxBXxLj1m4HMXBm9WZZmCWVbPjX16EHwv99vp",
           balances: %Plaid.Accounts.Account.Balances{
             available: 100,
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
         },
         %Plaid.Accounts.Account{
           account_id: "dVzbVMLjrxTnLjX4G66XUp5GLklm4oiZy88yK",
           balances: %Plaid.Accounts.Account.Balances{
             available: nil,
             current: 410,
             iso_currency_code: "USD",
             limit: 2000,
             unofficial_currency_code: nil
           },
           mask: "3333",
           name: "Plaid Credit Card",
           official_name: "Plaid Diamond 12.5% APR Interest Credit Card",
           subtype: "credit card",
           type: "credit"
         },
         %Plaid.Accounts.Account{
           account_id: "Pp1Vpkl9w8sajvK6oEEKtr7vZxBnGpf7LxxLE",
           balances: %Plaid.Accounts.Account.Balances{
             available: nil,
             current: 65_262,
             iso_currency_code: "USD",
             limit: nil,
             unofficial_currency_code: nil
           },
           mask: "7777",
           name: "Plaid Student Loan",
           official_name: nil,
           subtype: "student",
           type: "loan"
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
       request_id: "qk5Bxes3gDfv4F2"
     }} =
      Plaid.Accounts.get_balance("access-prod-123xxx",
        test_api_host: api_host,
        client_id: "123",
        secret: "abc"
      )
  end
end
