defmodule Plaid.AuthTest do
  use ExUnit.Case
  use ExUnit.Case, async: true

  alias Plug.Conn

  setup do
    bypass = Bypass.open()
    api_host = "http://localhost:#{bypass.port}/"
    {:ok, bypass: bypass, api_host: api_host}
  end

  test "/auth/get", %{bypass: bypass, api_host: api_host} do
    Bypass.expect_once(bypass, "POST", "/auth/get", fn conn ->
      Conn.resp(conn, 200, ~s<{
        "accounts": [
          {
            "account_id": "vzeNDwK7KQIm4yEog683uElbp9GRLEFXGK98D",
            "balances": {
              "available": 100,
              "current": 110,
              "limit": null,
              "iso_currency_code": "USD",
              "unofficial_currency_code": null
            },
            "mask": "9606",
            "name": "Plaid Checking",
            "official_name": "Plaid Gold Checking",
            "subtype": "checking",
            "type": "depository"
          }
        ],
        "numbers": {
          "ach": [
            {
              "account": "9900009606",
              "account_id": "vzeNDwK7KQIm4yEog683uElbp9GRLEFXGK98D",
              "routing": "011401533",
              "wire_routing": "021000021"
            }
          ],
          "eft": [
            {
              "account": "111122223333",
              "account_id": "vzeNDwK7KQIm4yEog683uElbp9GRLEFXGK98D",
              "institution": "021",
              "branch": "01140"
            }
          ],
          "international": [
            {
              "account_id": "vzeNDwK7KQIm4yEog683uElbp9GRLEFXGK98D",
              "bic": "NWBKGB21",
              "iban": "GB29NWBK60161331926819"
            }
          ],
          "bacs": [
            {
              "account": "31926819",
              "account_id": "vzeNDwK7KQIm4yEog683uElbp9GRLEFXGK98D",
              "sort_code": "601613"
            }
          ]
        },
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
        "request_id": "m8MDnv9okwxFNBV"
      }>)
    end)

    {:ok,
     %Plaid.Auth{
       accounts: [
         %Plaid.Accounts.Account{
           account_id: "vzeNDwK7KQIm4yEog683uElbp9GRLEFXGK98D",
           balances: %Plaid.Accounts.Account.Balances{
             available: 100,
             current: 110,
             limit: nil,
             iso_currency_code: "USD",
             unofficial_currency_code: nil
           },
           mask: "9606",
           name: "Plaid Checking",
           official_name: "Plaid Gold Checking",
           subtype: "checking",
           type: "depository"
         }
       ],
       numbers: %Plaid.Auth.Numbers{
         ach: [
           %Plaid.Auth.Numbers.ACH{
             account: "9900009606",
             account_id: "vzeNDwK7KQIm4yEog683uElbp9GRLEFXGK98D",
             routing: "011401533",
             wire_routing: "021000021"
           }
         ],
         eft: [
           %Plaid.Auth.Numbers.EFT{
             account: "111122223333",
             account_id: "vzeNDwK7KQIm4yEog683uElbp9GRLEFXGK98D",
             institution: "021",
             branch: "01140"
           }
         ],
         international: [
           %Plaid.Auth.Numbers.International{
             account_id: "vzeNDwK7KQIm4yEog683uElbp9GRLEFXGK98D",
             bic: "NWBKGB21",
             iban: "GB29NWBK60161331926819"
           }
         ],
         bacs: [
           %Plaid.Auth.Numbers.BACS{
             account: "31926819",
             account_id: "vzeNDwK7KQIm4yEog683uElbp9GRLEFXGK98D",
             sort_code: "601613"
           }
         ]
       },
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
       request_id: "m8MDnv9okwxFNBV"
     }} =
      Plaid.Auth.get(
        "access-prod-123xxx",
        test_api_host: api_host,
        client_id: "123",
        secret: "abc"
      )
  end
end
