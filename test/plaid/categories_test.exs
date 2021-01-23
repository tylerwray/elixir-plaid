defmodule Plaid.CategoriesTest do
  use ExUnit.Case
  use ExUnit.Case, async: true

  alias Plug.Conn

  setup do
    bypass = Bypass.open()
    api_host = "http://localhost:#{bypass.port}/"
    {:ok, bypass: bypass, api_host: api_host}
  end

  test "/categories/get", %{bypass: bypass, api_host: api_host} do
    Bypass.expect_once(bypass, "POST", "/categories/get", fn conn ->
      Conn.resp(conn, 200, ~s<{
        "categories": [
          {
            "category_id": "10000000",
            "group": "special",
            "hierarchy": [
              "Bank Fees"
            ]
          },
          {
            "category_id": "10001000",
            "group": "special",
            "hierarchy": [
              "Bank Fees",
              "Overdraft"
            ]
          },
          {
            "category_id": "12001000",
            "group": "place",
            "hierarchy": [
              "Community",
              "Animal Shelter"
            ]
          }
        ],
        "request_id": "1vwmF5TBQwiqfwP"
      }>)
    end)

    {:ok,
     %Plaid.Categories{
       categories: [
         %Plaid.Categories.Category{
           category_id: "10000000",
           group: "special",
           hierarchy: [
             "Bank Fees"
           ]
         },
         %Plaid.Categories.Category{
           category_id: "10001000",
           group: "special",
           hierarchy: [
             "Bank Fees",
             "Overdraft"
           ]
         },
         %Plaid.Categories.Category{
           category_id: "12001000",
           group: "place",
           hierarchy: [
             "Community",
             "Animal Shelter"
           ]
         }
       ],
       request_id: "1vwmF5TBQwiqfwP"
     }} =
      Plaid.Categories.get(
        test_api_host: api_host,
        client_id: "123",
        secret: "abc"
      )
  end
end
