defmodule Plaid.AssetReportTest do
  use ExUnit.Case
  use ExUnit.Case, async: true

  alias Plug.Conn

  setup do
    bypass = Bypass.open()
    api_host = "http://localhost:#{bypass.port}"
    {:ok, bypass: bypass, api_host: api_host}
  end

  test "POST /asset_report/create", %{bypass: bypass, api_host: api_host} do
    Bypass.expect_once(bypass, "POST", "/asset_report/create", fn conn ->
      Conn.resp(conn, 200, ~s<{
        "asset_report_token": "assets-sandbox-6f12f5bb-22dd-4855-b918-f47ec439198a",
        "asset_report_id": "1f414183-220c-44f5-b0c8-bc0e6d4053bb",
        "request_id": "Iam3b"
      }>)
    end)

    {:ok,
     %Plaid.AssetReport.AsyncResponse{
       asset_report_token: "assets-sandbox-6f12f5bb-22dd-4855-b918-f47ec439198a",
       asset_report_id: "1f414183-220c-44f5-b0c8-bc0e6d4053bb",
       request_id: "Iam3b"
     }} =
      Plaid.AssetReport.create(
        [
          "access-prod-123xxx",
          "access-prod-456xxx"
        ],
        5,
        %{
          client_report_id: "crid_123xxx",
          webhook: "https://localhost:1234/webhooks/plaid",
          user: %Plaid.AssetReport.User{
            client_user_id: "123",
            first_name: "John",
            middle_name: "Henry",
            last_name: "Henderson",
            ssn: "123-45-6789",
            phone_number: "+18013217654",
            email: "test@example.com"
          }
        },
        test_api_host: api_host,
        client_id: "123",
        secret: "abc"
      )
  end

  test "POST /asset_report/get", %{bypass: bypass, api_host: api_host} do
    Bypass.expect_once(bypass, "POST", "/asset_report/get", fn conn ->
      Conn.resp(conn, 200, ~s<{
        "report": {
          "asset_report_id": "bf3a0490-344c-4620-a219-2693162e4b1d",
          "client_report_id": "123abc",
          "date_generated": "2020-06-05T22:47:53Z",
          "days_requested": 3,
          "items": [
            {
              "accounts": [
                {
                  "account_id": "3gE5gnRzNyfXpBK5wEEKcymJ5albGVUqg77gr",
                  "balances": {
                    "available": 200,
                    "current": 210,
                    "iso_currency_code": "USD",
                    "limit": null,
                    "unofficial_currency_code": null
                  },
                  "days_available": 3,
                  "historical_balances": [
                    {
                      "current": 210,
                      "date": "2020-06-04",
                      "iso_currency_code": "USD",
                      "unofficial_currency_code": null
                    }
                  ],
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
                        }
                      ],
                      "emails": [
                        {
                          "data": "accountholder0@example.com",
                          "primary": true,
                          "type": "primary"
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
                        }
                      ]
                    }
                  ],
                  "ownership_type": null,
                  "subtype": "savings",
                  "transactions": [
                    {
                      "account_id": "DAeG5XMnP3snZxNZJ1z3hMgbKRgM3BTz7AWnk",
                      "amount": 25,
                      "date": "2021-01-10",
                      "iso_currency_code": "USD",
                      "original_description": "CREDIT CARD 3333 PAYMENT *//",
                      "pending": false,
                      "transaction_id": "x1jm7MPDA3ijNveNwg8lhq5dmqJjr3U9WmD3G",
                      "unofficial_currency_code": null
                    }
                  ],
                  "type": "depository"
                }
              ],
              "date_last_updated": "2020-06-05T22:47:52Z",
              "institution_id": "ins_3",
              "institution_name": "Chase",
              "item_id": "eVBnVMp7zdTJLkRNr33Rs6zr7KNJqBFL9DrE6"
            }
          ],
          "user": {
            "client_user_id": "123456789",
            "email": "accountholder0@example.com",
            "first_name": "Alberta",
            "last_name": "Charleson",
            "middle_name": "Bobbeth",
            "phone_number": "111-222-3333",
            "ssn": "123-45-6789"
          }
        },
        "warnings": [
          {
            "warning_type": "ASSET_REPORT_WARNING",
            "warning_code": "OWNERS_UNAVAILABLE",
            "cause": {
              "item_id": "eVBnVMp7zdTJLkRNr33Rs6zr7KNJqBFL9DrE6",
              "error": {
                "error_type": "ASSET_REPORT_ERROR",
                "error_code": "USER_SETUP_REQUIRED",
                "error_message": "the account has not been fully set up. prompt the user to visit the issuing institution's site and finish the setup process",
                "display_message": "The given account is not fully setup. Please visit your financial institution's website to setup your account.",
                "request_id": "eYupqX1mZkEuQRx",
                "causes": [],
                "status": 400,
                "documentation_url": "https://plaid.com/docs/api/error",
                "suggested_action": "Prompt the user to setup their account."
              }
            }
          }
        ],
        "request_id": "eYupqX1mZkEuQRx"
      }>)
    end)

    {:ok,
     %Plaid.AssetReport.GetResponse{
       report: %Plaid.AssetReport.Report{
         asset_report_id: "bf3a0490-344c-4620-a219-2693162e4b1d",
         client_report_id: "123abc",
         date_generated: "2020-06-05T22:47:53Z",
         days_requested: 3,
         items: [
           %Plaid.AssetReport.Report.Item{
             accounts: [
               %Plaid.Accounts.Account{
                 account_id: "3gE5gnRzNyfXpBK5wEEKcymJ5albGVUqg77gr",
                 balances: %Plaid.Accounts.Account.Balances{
                   available: 200,
                   current: 210,
                   iso_currency_code: "USD",
                   limit: nil,
                   unofficial_currency_code: nil
                 },
                 days_available: 3,
                 historical_balances: [
                   %Plaid.Accounts.Account.HistoricalBalances{
                     current: 210,
                     date: "2020-06-04",
                     iso_currency_code: "USD",
                     unofficial_currency_code: nil
                   }
                 ],
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
                       }
                     ],
                     emails: [
                       %Plaid.Identity.Email{
                         data: "accountholder0@example.com",
                         primary: true,
                         type: "primary"
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
                       }
                     ]
                   }
                 ],
                 ownership_type: nil,
                 subtype: "savings",
                 transactions: [
                   %Plaid.Transactions.Transaction{
                     account_id: "DAeG5XMnP3snZxNZJ1z3hMgbKRgM3BTz7AWnk",
                     amount: 25,
                     date: "2021-01-10",
                     iso_currency_code: "USD",
                     original_description: "CREDIT CARD 3333 PAYMENT *//",
                     pending: false,
                     transaction_id: "x1jm7MPDA3ijNveNwg8lhq5dmqJjr3U9WmD3G",
                     unofficial_currency_code: nil
                   }
                 ],
                 type: "depository"
               }
             ],
             date_last_updated: "2020-06-05T22:47:52Z",
             institution_id: "ins_3",
             institution_name: "Chase",
             item_id: "eVBnVMp7zdTJLkRNr33Rs6zr7KNJqBFL9DrE6"
           }
         ],
         user: %Plaid.AssetReport.User{
           client_user_id: "123456789",
           email: "accountholder0@example.com",
           first_name: "Alberta",
           last_name: "Charleson",
           middle_name: "Bobbeth",
           phone_number: "111-222-3333",
           ssn: "123-45-6789"
         }
       },
       warnings: [
         %Plaid.AssetReport.Warning{
           warning_type: "ASSET_REPORT_WARNING",
           warning_code: "OWNERS_UNAVAILABLE",
           cause: %Plaid.AssetReport.Warning.Cause{
             item_id: "eVBnVMp7zdTJLkRNr33Rs6zr7KNJqBFL9DrE6",
             error: %Plaid.Error{
               error_type: "ASSET_REPORT_ERROR",
               error_code: "USER_SETUP_REQUIRED",
               error_message:
                 "the account has not been fully set up. prompt the user to visit the issuing institution's site and finish the setup process",
               display_message:
                 "The given account is not fully setup. Please visit your financial institution's website to setup your account.",
               request_id: "eYupqX1mZkEuQRx",
               causes: [],
               status: 400,
               documentation_url: "https://plaid.com/docs/api/error",
               suggested_action: "Prompt the user to setup their account."
             }
           }
         }
       ],
       request_id: "eYupqX1mZkEuQRx"
     }} =
      Plaid.AssetReport.get(
        "assets-sandbox-6f12f5bb-22dd-4855-b918-f47ec439198a",
        %{include_insights: true},
        test_api_host: api_host,
        client_id: "123",
        secret: "abc"
      )
  end

  test "POST /asset_report/pdf/get", %{bypass: bypass, api_host: api_host} do
    Bypass.expect_once(bypass, "POST", "/asset_report/pdf/get", fn conn ->
      conn
      |> Conn.put_resp_header("content-type", "application/pdf")
      |> Conn.resp(200, <<0, 1, 2, 3>>)
    end)

    {:ok, body} =
      Plaid.AssetReport.get_pdf(
        "assets-sandbox-6f12f5bb-22dd-4855-b918-f47ec439198a",
        test_api_host: api_host,
        client_id: "123",
        secret: "abc"
      )

    assert body == <<0, 1, 2, 3>>
  end

  test "POST /asset_report/refresh", %{bypass: bypass, api_host: api_host} do
    Bypass.expect_once(bypass, "POST", "/asset_report/refresh", fn conn ->
      Conn.resp(conn, 200, ~s<{
        "asset_report_token": "assets-sandbox-6f12f5bb-22dd-4855-b918-f47ec439198a",
        "asset_report_id": "1f414183-220c-44f5-b0c8-bc0e6d4053bb",
        "request_id": "Iam3b"
      }>)
    end)

    {:ok,
     %Plaid.AssetReport.AsyncResponse{
       asset_report_token: "assets-sandbox-6f12f5bb-22dd-4855-b918-f47ec439198a",
       asset_report_id: "1f414183-220c-44f5-b0c8-bc0e6d4053bb",
       request_id: "Iam3b"
     }} =
      Plaid.AssetReport.refresh(
        "assets-prod-123xxx",
        %{
          client_report_id: "crid_123xxx",
          webhook: "https://localhost:1234/webhooks/plaid",
          days_requested: 3,
          user: %Plaid.AssetReport.User{
            client_user_id: "123",
            first_name: "John",
            middle_name: "Henry",
            last_name: "Henderson",
            ssn: "123-45-6789",
            phone_number: "+18013217654",
            email: "test@example.com"
          }
        },
        test_api_host: api_host,
        client_id: "123",
        secret: "abc"
      )
  end

  test "POST /asset_report/filter", %{bypass: bypass, api_host: api_host} do
    Bypass.expect_once(bypass, "POST", "/asset_report/filter", fn conn ->
      Conn.resp(conn, 200, ~s<{
        "asset_report_token": "assets-sandbox-6f12f5bb-22dd-4855-b918-f47ec439198a",
        "asset_report_id": "1f414183-220c-44f5-b0c8-bc0e6d4053bb",
        "request_id": "Iam3b"
      }>)
    end)

    {:ok,
     %Plaid.AssetReport.AsyncResponse{
       asset_report_token: "assets-sandbox-6f12f5bb-22dd-4855-b918-f47ec439198a",
       asset_report_id: "1f414183-220c-44f5-b0c8-bc0e6d4053bb",
       request_id: "Iam3b"
     }} =
      Plaid.AssetReport.filter(
        "assets-prod-123xxx",
        ["3gE5gnRzNyfXpBK5wEEKcymJ5albGVUqg77gr"],
        test_api_host: api_host,
        client_id: "123",
        secret: "abc"
      )
  end

  test "POST /asset_report/remove", %{bypass: bypass, api_host: api_host} do
    Bypass.expect_once(bypass, "POST", "/asset_report/remove", fn conn ->
      Conn.resp(conn, 200, ~s<{"removed": true, "request_id": "I6Hzd"}>)
    end)

    {:ok,
     %Plaid.AssetReport.RemoveResponse{
       removed: true,
       request_id: "I6Hzd"
     }} =
      Plaid.AssetReport.remove(
        "assets-prod-123xxx",
        test_api_host: api_host,
        client_id: "123",
        secret: "abc"
      )
  end

  test "POST /asset_report/audit_copy/create", %{bypass: bypass, api_host: api_host} do
    Bypass.expect_once(bypass, "POST", "/asset_report/audit_copy/create", fn conn ->
      Conn.resp(conn, 200, ~s<{
        "audit_copy_token": "a-sandbox-3TAU2CWVYBDVRHUCAAAI27ULU4",
        "request_id": "Iam3b"
      }>)
    end)

    {:ok,
     %Plaid.AssetReport.CreateAuditCopyResponse{
       audit_copy_token: "a-sandbox-3TAU2CWVYBDVRHUCAAAI27ULU4",
       request_id: "Iam3b"
     }} =
      Plaid.AssetReport.create_audit_copy(
        "assets-prod-123xxx",
        "fannie_mae",
        test_api_host: api_host,
        client_id: "123",
        secret: "abc"
      )
  end

  test "POST /asset_report/audit_copy/remove", %{bypass: bypass, api_host: api_host} do
    Bypass.expect_once(bypass, "POST", "/asset_report/audit_copy/remove", fn conn ->
      Conn.resp(conn, 200, ~s<{
        "removed": true,
        "request_id": "Iam3b"
      }>)
    end)

    {:ok,
     %Plaid.AssetReport.RemoveAuditCopyResponse{
       removed: true,
       request_id: "Iam3b"
     }} =
      Plaid.AssetReport.remove_audit_copy(
        "a-sandbox-3TAU2CWVYBDVRHUCAAAI27ULU4",
        test_api_host: api_host,
        client_id: "123",
        secret: "abc"
      )
  end
end
