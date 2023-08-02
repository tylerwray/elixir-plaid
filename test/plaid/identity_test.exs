defmodule Plaid.IdentityTest do
  use ExUnit.Case, async: true

  alias Plug.Conn

  setup do
    bypass = Bypass.open()
    api_host = "http://localhost:#{bypass.port}"
    {:ok, bypass: bypass, api_host: api_host}
  end

  def user_identity(opts \\ []) do
    %Plaid.Identity.Match.User{
      legal_name: Keyword.get(opts, :legal_name, "full legal name"),
      phone_number: "123-456-7890",
      email_address: "email@address.com",
      address: %Plaid.Identity.Match.User.Address{
        street: "123 Main St",
        city: "New York",
        region: "NY",
        postal_code: "10001",
        country: "US"
      }
    }
  end

  test "/identity/get", %{bypass: bypass, api_host: api_host} do
    Bypass.expect_once(bypass, "POST", "/identity/get", fn conn ->
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
                    "type": "mobile"
                  }
                ]
              }
            ],
            "subtype": "checking",
            "type": "depository"
          },
          {
            "account_id": "3gE5gnRzNyfXpBK5wEEKcymJ5albGVUqg77gr",
            "balances": {
              "available": 200,
              "current": 210,
              "iso_currency_code": "USD",
              "limit": null,
              "unofficial_currency_code": null
            },
            "mask": "1111",
            "name": "Plaid Saving",
            "official_name": "Plaid Silver Standard 0.1% Interest Saving",
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
                    "type": "mobile"
                  }
                ]
              }
            ],
            "subtype": "savings",
            "type": "depository"
          }
        ],
        "item": {
          "available_products": [
            "balance",
            "investments"
          ],
          "billed_products": [
            "assets",
            "auth",
            "identity",
            "liabilities",
            "transactions"
          ],
          "consent_expiration_time": null,
          "error": null,
          "institution_id": "ins_3",
          "item_id": "eVBnVMp7zdTJLkRNr33Rs6zr7KNJqBFL9DrE6",
          "webhook": "https://www.genericwebhookurl.com/webhook"
        },
        "request_id": "3nARps6TOYtbACO"
      }>)
    end)

    {:ok,
     %Plaid.Identity.GetResponse{
       accounts: [
         %Plaid.Account{
           account_id: "BxBXxLj1m4HMXBm9WZZmCWVbPjX16EHwv99vp",
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
                   type: "mobile"
                 }
               ]
             }
           ],
           subtype: "checking",
           type: "depository"
         },
         %Plaid.Account{
           account_id: "3gE5gnRzNyfXpBK5wEEKcymJ5albGVUqg77gr",
           balances: %Plaid.Account.Balances{
             available: 200,
             current: 210,
             iso_currency_code: "USD",
             limit: nil,
             unofficial_currency_code: nil
           },
           mask: "1111",
           name: "Plaid Saving",
           official_name: "Plaid Silver Standard 0.1% Interest Saving",
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
                   type: "mobile"
                 }
               ]
             }
           ],
           subtype: "savings",
           type: "depository"
         }
       ],
       item: %Plaid.Item{
         available_products: [
           "balance",
           "investments"
         ],
         billed_products: [
           "assets",
           "auth",
           "identity",
           "liabilities",
           "transactions"
         ],
         consent_expiration_time: nil,
         error: nil,
         institution_id: "ins_3",
         item_id: "eVBnVMp7zdTJLkRNr33Rs6zr7KNJqBFL9DrE6",
         webhook: "https://www.genericwebhookurl.com/webhook"
       },
       request_id: "3nARps6TOYtbACO"
     }} =
      Plaid.Identity.get(
        "access-prod-123xxx",
        %{
          account_ids: [
            "BxBXxLj1m4HMXBm9WZZmCWVbPjX16EHwv99vp",
            "3gE5gnRzNyfXpBK5wEEKcymJ5albGVUqg77gr"
          ]
        },
        test_api_host: api_host,
        client_id: "123",
        secret: "abc"
      )
  end

  test "/identity/get without options", %{bypass: bypass, api_host: api_host} do
    Bypass.expect_once(bypass, "POST", "/identity/get", fn conn ->
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
                    "type": "mobile"
                  }
                ]
              }
            ],
            "subtype": "checking",
            "type": "depository"
          },
          {
            "account_id": "3gE5gnRzNyfXpBK5wEEKcymJ5albGVUqg77gr",
            "balances": {
              "available": 200,
              "current": 210,
              "iso_currency_code": "USD",
              "limit": null,
              "unofficial_currency_code": null
            },
            "mask": "1111",
            "name": "Plaid Saving",
            "official_name": "Plaid Silver Standard 0.1% Interest Saving",
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
                    "type": "mobile"
                  }
                ]
              }
            ],
            "subtype": "savings",
            "type": "depository"
          }
        ],
        "item": {
          "available_products": [
            "balance",
            "investments"
          ],
          "billed_products": [
            "assets",
            "auth",
            "identity",
            "liabilities",
            "transactions"
          ],
          "consent_expiration_time": null,
          "error": null,
          "institution_id": "ins_3",
          "item_id": "eVBnVMp7zdTJLkRNr33Rs6zr7KNJqBFL9DrE6",
          "webhook": "https://www.genericwebhookurl.com/webhook"
        },
        "request_id": "3nARps6TOYtbACO"
      }>)
    end)

    {:ok,
     %Plaid.Identity.GetResponse{
       accounts: [
         %Plaid.Account{
           account_id: "BxBXxLj1m4HMXBm9WZZmCWVbPjX16EHwv99vp",
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
                   type: "mobile"
                 }
               ]
             }
           ],
           subtype: "checking",
           type: "depository"
         },
         %Plaid.Account{
           account_id: "3gE5gnRzNyfXpBK5wEEKcymJ5albGVUqg77gr",
           balances: %Plaid.Account.Balances{
             available: 200,
             current: 210,
             iso_currency_code: "USD",
             limit: nil,
             unofficial_currency_code: nil
           },
           mask: "1111",
           name: "Plaid Saving",
           official_name: "Plaid Silver Standard 0.1% Interest Saving",
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
                   type: "mobile"
                 }
               ]
             }
           ],
           subtype: "savings",
           type: "depository"
         }
       ],
       item: %Plaid.Item{
         available_products: [
           "balance",
           "investments"
         ],
         billed_products: [
           "assets",
           "auth",
           "identity",
           "liabilities",
           "transactions"
         ],
         consent_expiration_time: nil,
         error: nil,
         institution_id: "ins_3",
         item_id: "eVBnVMp7zdTJLkRNr33Rs6zr7KNJqBFL9DrE6",
         webhook: "https://www.genericwebhookurl.com/webhook"
       },
       request_id: "3nARps6TOYtbACO"
     }} =
      Plaid.Identity.get(
        "access-prod-123xxx",
        test_api_host: api_host,
        client_id: "123",
        secret: "abc"
      )
  end

  test "/identity/match", %{bypass: bypass, api_host: api_host} do
    Bypass.expect_once(bypass, "POST", "/identity/match", fn conn ->
      Conn.resp(conn, 200, ~s<{
        "accounts": [
          {
            "account_id": "GAQ8ENe3n5CKxnZbLJMAIy94W8nAG7CGgZojn",
            "address": { "is_postal_code_match": true, "score": 100 },
            "balances": {
              "available": 234.56,
              "current": 6543.23,
              "iso_currency_code": "USD",
              "limit": null,
              "unofficial_currency_code": null
            },
            "verification_status": "automatically_verified",
            "persistent_account_id": "acct_123xxx",
            "email_address": { "score": 100 },
            "legal_name": {
              "is_business_name_detected": false,
              "is_first_name_or_last_name_match": false,
              "is_nickname_match": true,
              "score": 87
            },
            "mask": "5555",
            "name": "Plaid Checking",
            "official_name": "Plaid Instant Daily Checking Account",
            "phone_number": { "score": 23 },
            "subtype": "checking",
            "type": "depository"
          }
        ],
        "item": {
          "available_products": [
            "balance",
            "investments"
          ],
          "billed_products": [
            "assets",
            "auth",
            "identity",
            "liabilities",
            "transactions"
          ],
          "consent_expiration_time": null,
          "error": null,
          "institution_id": "ins_3",
          "item_id": "eVBnVMp7zdTJLkRNr33Rs6zr7KNJqBFL9DrE6",
          "update_type": "background",
          "webhook": "https://www.genericwebhookurl.com/webhook"
        }
      }>)
    end)

    assert {:ok,
            %Plaid.Identity.MatchResponse{
              accounts: [
                %Plaid.Identity.Match.Account{
                  account_id: "GAQ8ENe3n5CKxnZbLJMAIy94W8nAG7CGgZojn",
                  balances: %Plaid.Account.Balances{
                    available: 234.56,
                    current: 6543.23,
                    limit: nil,
                    iso_currency_code: "USD",
                    unofficial_currency_code: nil
                  },
                  mask: "5555",
                  name: "Plaid Checking",
                  official_name: "Plaid Instant Daily Checking Account",
                  type: "depository",
                  subtype: "checking",
                  verification_status: "automatically_verified",
                  persistent_account_id: "acct_123xxx",
                  legal_name: %Plaid.Identity.Match.Account.LegalName{
                    score: 87,
                    is_nickname_match: true,
                    is_first_name_or_last_name_match: false,
                    is_business_name_detected: false
                  },
                  phone_number: %Plaid.Identity.Match.Account.PhoneNumber{score: 23},
                  email_address: %Plaid.Identity.Match.Account.EmailAddress{score: 100},
                  address: %Plaid.Identity.Match.Account.Address{
                    score: 100,
                    is_postal_code_match: true
                  }
                }
              ],
              item: %Plaid.Identity.Match.Item{
                available_products: [
                  "balance",
                  "investments"
                ],
                billed_products: [
                  "assets",
                  "auth",
                  "identity",
                  "liabilities",
                  "transactions"
                ],
                consent_expiration_time: nil,
                error: nil,
                institution_id: "ins_3",
                item_id: "eVBnVMp7zdTJLkRNr33Rs6zr7KNJqBFL9DrE6",
                update_type: "background",
                webhook: "https://www.genericwebhookurl.com/webhook"
              }
            }} =
             Plaid.Identity.match(
               "access-prod-123xxx",
               %{user: user_identity()},
               test_api_host: api_host,
               client_id: "123",
               secret: "abc"
             )
  end

  test "/identity/match with partial response", %{bypass: bypass, api_host: api_host} do
    Bypass.expect_once(bypass, "POST", "/identity/match", fn conn ->
      Conn.resp(conn, 200, ~s<{
        "accounts": [
          {
            "account_id": "GAQ8ENe3n5CKxnZbLJMAIy94W8nAG7CGgZojn",
            "address": { "is_postal_code_match": null, "score": null },
            "balances": {
              "available": 234.56,
              "current": 6543.23,
              "iso_currency_code": "USD",
              "limit": null,
              "unofficial_currency_code": null
            },
            "verification_status": "automatically_verified",
            "persistent_account_id": "acct_123xxx",
            "email_address": { "score": 100 },
            "legal_name": {
              "is_business_name_detected": null,
              "is_first_name_or_last_name_match": null,
              "is_nickname_match": null,
              "score": null
            },
            "mask": "5555",
            "name": "Plaid Checking",
            "official_name": "Plaid Instant Daily Checking Account",
            "phone_number": { "score": 23 },
            "subtype": "checking",
            "type": "depository"
          }
        ],
        "item": {
          "available_products": [
            "balance",
            "investments"
          ],
          "billed_products": [
            "assets",
            "auth",
            "identity",
            "liabilities",
            "transactions"
          ],
          "consent_expiration_time": null,
          "error": null,
          "institution_id": "ins_3",
          "item_id": "eVBnVMp7zdTJLkRNr33Rs6zr7KNJqBFL9DrE6",
          "update_type": "background",
          "webhook": "https://www.genericwebhookurl.com/webhook"
        }
      }>)
    end)

    assert {:ok,
            %Plaid.Identity.MatchResponse{
              accounts: [
                %Plaid.Identity.Match.Account{
                  account_id: "GAQ8ENe3n5CKxnZbLJMAIy94W8nAG7CGgZojn",
                  balances: %Plaid.Account.Balances{
                    available: 234.56,
                    current: 6543.23,
                    limit: nil,
                    iso_currency_code: "USD",
                    unofficial_currency_code: nil
                  },
                  mask: "5555",
                  name: "Plaid Checking",
                  official_name: "Plaid Instant Daily Checking Account",
                  type: "depository",
                  subtype: "checking",
                  verification_status: "automatically_verified",
                  persistent_account_id: "acct_123xxx",
                  legal_name: %Plaid.Identity.Match.Account.LegalName{
                    score: nil,
                    is_nickname_match: nil,
                    is_first_name_or_last_name_match: nil,
                    is_business_name_detected: nil
                  },
                  phone_number: %Plaid.Identity.Match.Account.PhoneNumber{score: 23},
                  email_address: %Plaid.Identity.Match.Account.EmailAddress{score: 100},
                  address: %Plaid.Identity.Match.Account.Address{
                    score: nil,
                    is_postal_code_match: nil
                  }
                }
              ],
              item: %Plaid.Identity.Match.Item{
                available_products: [
                  "balance",
                  "investments"
                ],
                billed_products: [
                  "assets",
                  "auth",
                  "identity",
                  "liabilities",
                  "transactions"
                ],
                consent_expiration_time: nil,
                error: nil,
                institution_id: "ins_3",
                item_id: "eVBnVMp7zdTJLkRNr33Rs6zr7KNJqBFL9DrE6",
                update_type: "background",
                webhook: "https://www.genericwebhookurl.com/webhook"
              }
            }} =
             Plaid.Identity.match(
               "access-prod-123xxx",
               %{user: user_identity(legal_name: nil)},
               test_api_host: api_host,
               client_id: "123",
               secret: "abc"
             )
  end
end
