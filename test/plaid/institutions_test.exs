defmodule Plaid.InstitutionsTest do
  use ExUnit.Case, async: true

  alias Plug.Conn

  setup do
    bypass = Bypass.open()
    api_host = "http://localhost:#{bypass.port}/"
    {:ok, bypass: bypass, api_host: api_host}
  end

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
            ]
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
           ]
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

  test "/institutions/get_by_id", %{bypass: bypass, api_host: api_host} do
    Bypass.expect_once(bypass, "POST", "/institutions/get_by_id", fn conn ->
      Conn.resp(conn, 200, ~s<{
        "institution": {
          "country_codes": [
            "US"
          ],
          "institution_id": "ins_109512",
          "name": "Houndstooth Bank",
          "products": [
            "auth",
            "balance",
            "identity",
            "transactions"
          ],
          "routing_numbers": [
            "110000000"
          ],
          "oauth": false,
          "status": {
            "item_logins": {
              "status": "HEALTHY",
              "last_status_change": "2019-02-15T15:53:00Z",
              "breakdown": {
                "success": 0.9,
                "error_plaid": 0.01,
                "error_institution": 0.09
              }
            },
            "transactions_updates": {
              "status": "HEALTHY",
              "last_status_change": "2019-02-12T08:22:00Z",
              "breakdown": {
                "success": 0.95,
                "error_plaid": 0.02,
                "error_institution": 0.03,
                "refresh_interval": "NORMAL"
              }
            },
            "auth": {
              "status": "HEALTHY",
              "last_status_change": "2019-02-15T15:53:00Z",
              "breakdown": {
                "success": 0.91,
                "error_plaid": 0.01,
                "error_institution": 0.08
              }
            },
            "balance": {
              "status": "HEALTHY",
              "last_status_change": "2019-02-15T15:53:00Z",
              "breakdown": {
                "success": 0.89,
                "error_plaid": 0.02,
                "error_institution": 0.09
              }
            },
            "identity": {
              "status": "DEGRADED",
              "last_status_change": "2019-02-15T15:50:00Z",
              "breakdown": {
                "success": 0.42,
                "error_plaid": 0.08,
                "error_institution": 0.5
              }
            },
            "investments_updates": {
              "status": "HEALTHY",
              "last_status_change": "2019-02-12T08:22:00Z",
              "breakdown": {
                "success": 0.95,
                "error_plaid": 0.02,
                "error_institution": 0.03,
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
          },
          "primary_color": "#004966",
          "url": "https://plaid.com",
          "logo": null
        },
        "request_id": "m8MDnv9okwxFNBV"
      }>)
    end)

    {:ok,
     %Plaid.Institutions.GetByIdResponse{
       institution: %Plaid.Institution{
         country_codes: [
           "US"
         ],
         institution_id: "ins_109512",
         name: "Houndstooth Bank",
         products: [
           "auth",
           "balance",
           "identity",
           "transactions"
         ],
         routing_numbers: [
           "110000000"
         ],
         oauth: false,
         status: %Plaid.Institution.Status{
           item_logins: %Plaid.Institution.Status.ItemLogins{
             status: "HEALTHY",
             last_status_change: "2019-02-15T15:53:00Z",
             breakdown: %Plaid.Institution.Status.Breakdown{
               success: 0.9,
               error_plaid: 0.01,
               error_institution: 0.09
             }
           },
           transactions_updates: %Plaid.Institution.Status.TransactionsUpdates{
             status: "HEALTHY",
             last_status_change: "2019-02-12T08:22:00Z",
             breakdown: %Plaid.Institution.Status.Breakdown{
               success: 0.95,
               error_plaid: 0.02,
               error_institution: 0.03,
               refresh_interval: "NORMAL"
             }
           },
           auth: %Plaid.Institution.Status.Auth{
             status: "HEALTHY",
             last_status_change: "2019-02-15T15:53:00Z",
             breakdown: %Plaid.Institution.Status.Breakdown{
               success: 0.91,
               error_plaid: 0.01,
               error_institution: 0.08
             }
           },
           balance: %Plaid.Institution.Status.Balance{
             status: "HEALTHY",
             last_status_change: "2019-02-15T15:53:00Z",
             breakdown: %Plaid.Institution.Status.Breakdown{
               success: 0.89,
               error_plaid: 0.02,
               error_institution: 0.09
             }
           },
           identity: %Plaid.Institution.Status.Identity{
             status: "DEGRADED",
             last_status_change: "2019-02-15T15:50:00Z",
             breakdown: %Plaid.Institution.Status.Breakdown{
               success: 0.42,
               error_plaid: 0.08,
               error_institution: 0.5
             }
           },
           investments_updates: %Plaid.Institution.Status.InvestmentsUpdates{
             status: "HEALTHY",
             last_status_change: "2019-02-12T08:22:00Z",
             breakdown: %Plaid.Institution.Status.Breakdown{
               success: 0.95,
               error_plaid: 0.02,
               error_institution: 0.03,
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
         },
         primary_color: "#004966",
         url: "https://plaid.com",
         logo: nil
       },
       request_id: "m8MDnv9okwxFNBV"
     }} =
      Plaid.Institutions.get_by_id(
        "ins_1",
        ["US", "CA"],
        %{
          include_optional_metadata: true,
          include_status: true
        },
        test_api_host: api_host,
        client_id: "123",
        secret: "abc"
      )
  end

  test "/institutions/search", %{bypass: bypass, api_host: api_host} do
    Bypass.expect_once(bypass, "POST", "/institutions/search", fn conn ->
      Conn.resp(conn, 200, ~s<{
        "institutions": [
          {
            "country_codes": [
              "US"
            ],
            "institution_id": "ins_25",
            "name": "Ally Bank",
            "oauth": false,
            "products": [
              "assets",
              "auth",
              "balance",
              "transactions",
              "identity"
            ],
            "routing_numbers": ["1100000"]
          }
        ],
        "request_id": "Ggmk0enW4smO2Tp"
      }>)
    end)

    {:ok,
     %Plaid.Institutions.SearchResponse{
       institutions: [
         %Plaid.Institution{
           country_codes: [
             "US"
           ],
           institution_id: "ins_25",
           name: "Ally Bank",
           oauth: false,
           products: [
             "assets",
             "auth",
             "balance",
             "transactions",
             "identity"
           ],
           routing_numbers: ["1100000"]
         }
       ],
       request_id: "Ggmk0enW4smO2Tp"
     }} =
      Plaid.Institutions.search(
        %{
          query: "Ally",
          products: ["auth", "liabilities"],
          country_codes: ["US"]
        },
        %{
          oauth: false,
          include_optional_metadata: true,
          account_filter: %{
            loan: ["auto"]
          }
        },
        test_api_host: api_host,
        client_id: "123",
        secret: "abc"
      )
  end
end
