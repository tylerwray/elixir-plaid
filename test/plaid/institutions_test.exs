defmodule Plaid.InstitutionsTest do
  use ExUnit.Case
  use ExUnit.Case, async: true

  alias Plug.Conn

  setup do
    bypass = Bypass.open()
    api_host = "http://localhost:#{bypass.port}/"
    {:ok, bypass: bypass, api_host: api_host}
  end

  # Moving Plaid.Institutions.Institution -> Plaid.Institution. Should I?

  test "/institutions/get", %{bypass: bypass, api_host: api_host} do
    Bypass.expect_once(bypass, "POST", "/institutions/get", fn conn ->
      Conn.resp(conn, 200, ~s<{
        "institutions": [
          {
            "country_codes": [
              "US"
            ],
            "institution_id": "ins_1",
            "name": "Bank of America",
            "oauth": false,
            "products": [
              "assets",
              "auth",
              "balance",
              "transactions",
              "identity",
              "liabilities"
            ],
            "routing_numbers": [
              "011000138",
              "011200365",
              "011400495"
            ],
            "status": {
              "item_logins": {
                "status": "HEALTHY",
                "last_status_change": "2021-01-01T15:26:48Z",
                "breakdown": {
                  "success": 92.5,
                  "error_plaid": 0.5,
                  "error_institution": 7.0,
                  "refresh_interval": "NORMAL"
                }
              },
              "transactions_updates": {
                "status": "HEALTHY",
                "last_status_change": "2021-01-01T15:26:48Z",
                "breakdown": {
                  "success": 92.5,
                  "error_plaid": 0.5,
                  "error_institution": 7.0,
                  "refresh_interval": "NORMAL"
                }
              },
              "auth": {
                "status": "HEALTHY",
                "last_status_change": "2021-01-01T15:26:48Z",
                "breakdown": {
                  "success": 92.5,
                  "error_plaid": 0.5,
                  "error_institution": 7.0,
                  "refresh_interval": "NORMAL"
                }
              },
              "balance": {
                "status": "HEALTHY",
                "last_status_change": "2021-01-01T15:26:48Z",
                "breakdown": {
                  "success": 92.5,
                  "error_plaid": 0.5,
                  "error_institution": 7.0,
                  "refresh_interval": "NORMAL"
                }
              },
              "identity": {
                "status": "HEALTHY",
                "last_status_change": "2021-01-01T15:26:48Z",
                "breakdown": {
                  "success": 92.5,
                  "error_plaid": 0.5,
                  "error_institution": 7.0,
                  "refresh_interval": "NORMAL"
                }
              },
              "investments_updates": {
                "status": "HEALTHY",
                "last_status_change": "2021-01-01T15:26:48Z",
                "breakdown": {
                  "success": 92.5,
                  "error_plaid": 0.5,
                  "error_institution": 7.0,
                  "refresh_interval": "NORMAL"
                }
              },
              "health_incidents": [
                {
                  "start_date": "2021-01-01T15:26:48Z",
                  "end_date": "2021-01-02T15:26:48Z",
                  "title": "Site Down",
                  "incident_updates": [
                    {
                      "description": "Site is not down",
                      "status": "RESOLVED",
                      "updated_date": "2020-10-30T15:26:48Z"
                    },
                    {
                      "description": "Site is down",
                      "status": "INVESTIGATING",
                      "updated_date": "2020-10-30T14:26:48Z"
                    }
                  ]
                }
              ]
            }
          }
        ],
        "request_id": "tbFyCEqkU774ZGG",
        "total": 11384
      }>)
    end)

    {:ok,
     %Plaid.Institutions.GetResponse{
       institutions: [
         %Plaid.Institution{
           country_codes: [
             "US"
           ],
           institution_id: "ins_1",
           name: "Bank of America",
           oauth: false,
           products: [
             "assets",
             "auth",
             "balance",
             "transactions",
             "identity",
             "liabilities"
           ],
           routing_numbers: [
             "011000138",
             "011200365",
             "011400495"
           ],
           status: %Plaid.Institution.Status{
             item_logins: %Plaid.Institution.Status.ItemLogins{
               status: "HEALTHY",
               last_status_change: "2021-01-01T15:26:48Z",
               breakdown: %Plaid.Institution.Status.Breakdown{
                 success: 92.5,
                 error_plaid: 0.5,
                 error_institution: 7.0,
                 refresh_interval: "NORMAL"
               }
             },
             transactions_updates: %Plaid.Institution.Status.TransactionsUpdates{
               status: "HEALTHY",
               last_status_change: "2021-01-01T15:26:48Z",
               breakdown: %Plaid.Institution.Status.Breakdown{
                 success: 92.5,
                 error_plaid: 0.5,
                 error_institution: 7.0,
                 refresh_interval: "NORMAL"
               }
             },
             auth: %Plaid.Institution.Status.Auth{
               status: "HEALTHY",
               last_status_change: "2021-01-01T15:26:48Z",
               breakdown: %Plaid.Institution.Status.Breakdown{
                 success: 92.5,
                 error_plaid: 0.5,
                 error_institution: 7.0,
                 refresh_interval: "NORMAL"
               }
             },
             balance: %Plaid.Institution.Status.Balance{
               status: "HEALTHY",
               last_status_change: "2021-01-01T15:26:48Z",
               breakdown: %Plaid.Institution.Status.Breakdown{
                 success: 92.5,
                 error_plaid: 0.5,
                 error_institution: 7.0,
                 refresh_interval: "NORMAL"
               }
             },
             identity: %Plaid.Institution.Status.Identity{
               status: "HEALTHY",
               last_status_change: "2021-01-01T15:26:48Z",
               breakdown: %Plaid.Institution.Status.Breakdown{
                 success: 92.5,
                 error_plaid: 0.5,
                 error_institution: 7.0,
                 refresh_interval: "NORMAL"
               }
             },
             investments_updates: %Plaid.Institution.Status.InvestmentsUpdates{
               status: "HEALTHY",
               last_status_change: "2021-01-01T15:26:48Z",
               breakdown: %Plaid.Institution.Status.Breakdown{
                 success: 92.5,
                 error_plaid: 0.5,
                 error_institution: 7.0,
                 refresh_interval: "NORMAL"
               }
             },
             health_incidents: [
               %Plaid.Institution.Status.HealthIncident{
                 start_date: "2021-01-01T15:26:48Z",
                 end_date: "2021-01-02T15:26:48Z",
                 title: "Site Down",
                 incident_updates: [
                   %Plaid.Institution.Status.HealthIncidentUpdate{
                     description: "Site is not down",
                     status: "RESOLVED",
                     updated_date: "2020-10-30T15:26:48Z"
                   },
                   %Plaid.Institution.Status.HealthIncidentUpdate{
                     description: "Site is down",
                     status: "INVESTIGATING",
                     updated_date: "2020-10-30T14:26:48Z"
                   }
                 ]
               }
             ]
           }
         }
       ],
       request_id: "tbFyCEqkU774ZGG",
       total: 11_384
     }} =
      Plaid.Institutions.get(
        %{count: 3, offset: 2, country_codes: ["US", "CA"]},
        %{
          products: ["assets", "auth", "balance"],
          routing_numbers: ["123", "456"],
          oauth: false,
          include_optional_metadata: true
        },
        test_api_host: api_host,
        client_id: "123",
        secret: "abc"
      )
  end
end
