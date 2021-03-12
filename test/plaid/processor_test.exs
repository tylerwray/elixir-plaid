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

  test "/processor/auth/get", %{bypass: bypass, api_host: api_host} do
    Bypass.expect_once(bypass, "POST", "/processor/auth/get", fn conn ->
      Conn.resp(conn, 200, ~s<{
        "account": {
          "account_id": "QKKzevvp33HxPWpoqn6rI13BxW4awNSjnw4xv",
          "balances": {
            "available": 100,
            "current": 110,
            "limit": null
          },
          "mask": "0000",
          "name": "Plaid Checking",
          "official_name": "Plaid Gold Checking",
          "subtype": "checking",
          "type": "depository"
        },
        "numbers": {
          "ach": {
            "account": "9900009606",
            "account_id": "vzeNDwK7KQIm4yEog683uElbp9GRLEFXGK98D",
            "routing": "011401533",
            "wire_routing": "021000021"
          },
          "eft": {
            "account": "111122223333",
            "account_id": "vzeNDwK7KQIm4yEog683uElbp9GRLEFXGK98D",
            "institution": "021",
            "branch": "01140"
          },
          "international": {
            "account_id": "vzeNDwK7KQIm4yEog683uElbp9GRLEFXGK98D",
            "bic": "NWBKGB21",
            "iban": "GB29NWBK60161331926819"
          },
          "bacs": {
            "account": "31926819",
            "account_id": "vzeNDwK7KQIm4yEog683uElbp9GRLEFXGK98D",
            "sort_code": "601613"
          }
        },
        "request_id": "1zlMf"
      }>)
    end)

    {:ok,
     %Plaid.Processor.GetAuthResponse{
       account: %Plaid.Account{
         account_id: "QKKzevvp33HxPWpoqn6rI13BxW4awNSjnw4xv",
         balances: %Plaid.Account.Balances{
           available: 100,
           current: 110,
           limit: nil
         },
         mask: "0000",
         name: "Plaid Checking",
         official_name: "Plaid Gold Checking",
         subtype: "checking",
         type: "depository"
       },
       numbers: %Plaid.Processor.Numbers{
         ach: %Plaid.Auth.Numbers.ACH{
           account: "9900009606",
           account_id: "vzeNDwK7KQIm4yEog683uElbp9GRLEFXGK98D",
           routing: "011401533",
           wire_routing: "021000021"
         },
         eft: %Plaid.Auth.Numbers.EFT{
           account: "111122223333",
           account_id: "vzeNDwK7KQIm4yEog683uElbp9GRLEFXGK98D",
           institution: "021",
           branch: "01140"
         },
         international: %Plaid.Auth.Numbers.International{
           account_id: "vzeNDwK7KQIm4yEog683uElbp9GRLEFXGK98D",
           bic: "NWBKGB21",
           iban: "GB29NWBK60161331926819"
         },
         bacs: %Plaid.Auth.Numbers.BACS{
           account: "31926819",
           account_id: "vzeNDwK7KQIm4yEog683uElbp9GRLEFXGK98D",
           sort_code: "601613"
         }
       },
       request_id: "1zlMf"
     }} =
      Plaid.Processor.get_auth(
        "processor-prod-123xxx",
        test_api_host: api_host,
        client_id: "123",
        secret: "abc"
      )
  end

  test "/processor/balance/get", %{bypass: bypass, api_host: api_host} do
    Bypass.expect_once(bypass, "POST", "/processor/balance/get", fn conn ->
      Conn.resp(conn, 200, ~s<{
        "account": {
          "account_id": "QKKzevvp33HxPWpoqn6rI13BxW4awNSjnw4xv",
          "balances": {
            "available": 100,
            "current": 110,
            "limit": null
          },
          "mask": "0000",
          "name": "Plaid Checking",
          "official_name": "Plaid Gold Checking",
          "subtype": "checking",
          "type": "depository"
        },
        "request_id": "1zlMf"
      }>)
    end)

    {:ok,
     %Plaid.Processor.GetBalanceResponse{
       account: %Plaid.Account{
         account_id: "QKKzevvp33HxPWpoqn6rI13BxW4awNSjnw4xv",
         balances: %Plaid.Account.Balances{
           available: 100,
           current: 110,
           limit: nil
         },
         mask: "0000",
         name: "Plaid Checking",
         official_name: "Plaid Gold Checking",
         subtype: "checking",
         type: "depository"
       },
       request_id: "1zlMf"
     }} =
      Plaid.Processor.get_balance(
        "processor-prod-123xxx",
        test_api_host: api_host,
        client_id: "123",
        secret: "abc"
      )
  end

  test "/processor/identity/get", %{bypass: bypass, api_host: api_host} do
    Bypass.expect_once(bypass, "POST", "/processor/identity/get", fn conn ->
      Conn.resp(conn, 200, ~s<{
        "account": {
          "account_id": "XMGPJy4q1gsQoKd5z9R3tK8kJ9EWL8SdkgKMq",
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
          "owners": [
            {
              "addresses": [
                {
                  "data": {
                    "city": "Malakoff",
                    "country": "US",
                    "postal_code": "14236",
                    "region": "NY",
                    "street": "2992 Cameron Road"
                  },
                  "primary": true
                },
                {
                  "data": {
                    "city": "San Matias",
                    "country": "US",
                    "postal_code": "93405-2255",
                    "region": "CA",
                    "street": "2493 Leisure Lane"
                  },
                  "primary": false
                }
              ],
              "emails": [
                {
                  "data": "accountholder0@example.com",
                  "primary": true,
                  "type": "primary"
                },
                {
                  "data": "accountholder1@example.com",
                  "primary": false,
                  "type": "secondary"
                },
                {
                  "data": "extraordinarily.long.email.username.123456@reallylonghostname.com",
                  "primary": false,
                  "type": "other"
                }
              ],
              "names": [
                "Alberta Bobbeth Charleson"
              ],
              "phone_numbers": [
                {
                  "data": "1112223333",
                  "primary": false,
                  "type": "home"
                },
                {
                  "data": "1112224444",
                  "primary": false,
                  "type": "work"
                },
                {
                  "data": "1112225555",
                  "primary": false,
                  "type": "mobile1"
                }
              ]
            }
          ],
          "subtype": "checking",
          "type": "depository"
        },
        "request_id": "eOPkBl6t33veI2J"
      }>)
    end)

    {:ok,
     %Plaid.Processor.GetIdentityResponse{
       account: %Plaid.Account{
         account_id: "XMGPJy4q1gsQoKd5z9R3tK8kJ9EWL8SdkgKMq",
         balances: %Plaid.Account.Balances{
           available: 100,
           current: 110,
           iso_currency_code: "USD",
           limit: nil,
           unofficial_currency_code: nil
         },
         mask: "0000",
         name: "Plaid Checking",
         official_name: "Plaid Gold Standard 0% Interest Checking",
         owners: [
           %Plaid.Identity{
             addresses: [
               %Plaid.Identity.Address{
                 data: %Plaid.Address{
                   city: "Malakoff",
                   country: "US",
                   postal_code: "14236",
                   region: "NY",
                   street: "2992 Cameron Road"
                 },
                 primary: true
               },
               %Plaid.Identity.Address{
                 data: %Plaid.Address{
                   city: "San Matias",
                   country: "US",
                   postal_code: "93405-2255",
                   region: "CA",
                   street: "2493 Leisure Lane"
                 },
                 primary: false
               }
             ],
             emails: [
               %Plaid.Identity.Email{
                 data: "accountholder0@example.com",
                 primary: true,
                 type: "primary"
               },
               %Plaid.Identity.Email{
                 data: "accountholder1@example.com",
                 primary: false,
                 type: "secondary"
               },
               %Plaid.Identity.Email{
                 data: "extraordinarily.long.email.username.123456@reallylonghostname.com",
                 primary: false,
                 type: "other"
               }
             ],
             names: [
               "Alberta Bobbeth Charleson"
             ],
             phone_numbers: [
               %Plaid.Identity.PhoneNumber{
                 data: "1112223333",
                 primary: false,
                 type: "home"
               },
               %Plaid.Identity.PhoneNumber{
                 data: "1112224444",
                 primary: false,
                 type: "work"
               },
               %Plaid.Identity.PhoneNumber{
                 data: "1112225555",
                 primary: false,
                 type: "mobile1"
               }
             ]
           }
         ],
         subtype: "checking",
         type: "depository"
       },
       request_id: "eOPkBl6t33veI2J"
     }} =
      Plaid.Processor.get_identity(
        "processor-prod-123xxx",
        test_api_host: api_host,
        client_id: "123",
        secret: "abc"
      )
  end
end
