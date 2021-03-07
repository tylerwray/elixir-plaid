defmodule Plaid.EmployerTest do
  use ExUnit.Case, async: true

  alias Plug.Conn

  setup do
    bypass = Bypass.open()
    api_host = "http://localhost:#{bypass.port}/"
    {:ok, bypass: bypass, api_host: api_host}
  end

  test "/employers/search", %{bypass: bypass, api_host: api_host} do
    Bypass.expect_once(bypass, "POST", "/employers/search", fn conn ->
      Conn.resp(conn, 200, ~s<{
        "employers": [
          {
            "name": "Plaid Technologies Inc",
            "address": {
              "city": "San Francisco",
              "country": "US",
              "postal_code": "94103",
              "region": "CA",
              "street": "1098 Harrison St"
            },
            "confidence_score": 1,
            "employer_id": "emp_1"
          }
        ],
        "request_id": "ixTBLZGvhD4NnmB"
      }>)
    end)

    {:ok,
     %Plaid.Employer.SearchResponse{
       employers: [
         %Plaid.Employer{
           name: "Plaid Technologies Inc",
           address: %Plaid.Address{
             city: "San Francisco",
             country: "US",
             postal_code: "94103",
             region: "CA",
             street: "1098 Harrison St"
           },
           confidence_score: 1,
           employer_id: "emp_1"
         }
       ],
       request_id: "ixTBLZGvhD4NnmB"
     }} =
      Plaid.Employer.search(
        "Plaid Technologies",
        ["auth"],
        test_api_host: api_host,
        client_id: "123",
        secret: "abc"
      )
  end
end
