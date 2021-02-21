defmodule Plaid.PaymentInitiationTest do
  use ExUnit.Case
  use ExUnit.Case, async: true

  alias Plug.Conn

  setup do
    bypass = Bypass.open()
    api_host = "http://localhost:#{bypass.port}/"
    {:ok, bypass: bypass, api_host: api_host}
  end

  test "/payment_initiation/recipient/create", %{bypass: bypass, api_host: api_host} do
    Bypass.expect_once(bypass, "POST", "/payment_initiation/recipient/create", fn conn ->
      Conn.resp(conn, 200, ~s<{
        "recipient_id": "recipient-id-sandbox-9b6b4679-914b-445b-9450-efbdb80296f6",
        "request_id": "4zlKapIkTm8p5KM"
      }>)
    end)

    {:ok,
     %Plaid.PaymentInitiation.CreateRecipientResponse{
       recipient_id: "recipient-id-sandbox-9b6b4679-914b-445b-9450-efbdb80296f6",
       request_id: "4zlKapIkTm8p5KM"
     }} =
      Plaid.PaymentInitiation.create_recipient(
        "Wonder Wallet",
        %{
          iban: "GB29NWBK60161331926819",
          bacs: %Plaid.PaymentInitiation.BACS{
            account: "2930499299",
            sort_code: "601613"
          },
          address: %Plaid.PaymentInitiation.RecipientAddress{
            street: [
              "96 Guild Street",
              "9th Floor"
            ],
            city: "London",
            postal_code: "SE14 8JW",
            country: "GB"
          }
        },
        test_api_host: api_host,
        client_id: "123",
        secret: "abc"
      )
  end

  test "/payment_initiation/recipient/get", %{bypass: bypass, api_host: api_host} do
    Bypass.expect_once(bypass, "POST", "/payment_initiation/recipient/get", fn conn ->
      Conn.resp(conn, 200, ~s<{
        "recipient_id": "recipient-id-sandbox-9b6b4679-914b-445b-9450-efbdb80296f6",
        "name": "Wonder Wallet",
        "iban": "GB29NWBK60161331926819",
        "address": {
          "street": [
            "96 Guild Street",
            "9th Floor"
          ],
          "city": "London",
          "postal_code": "SE14 8JW",
          "country": "GB"
        },
        "request_id": "4zlKapIkTm8p5KM"
      }>)
    end)

    {:ok,
     %Plaid.PaymentInitiation.GetRecipientResponse{
       recipient_id: "recipient-id-sandbox-9b6b4679-914b-445b-9450-efbdb80296f6",
       name: "Wonder Wallet",
       iban: "GB29NWBK60161331926819",
       address: %Plaid.PaymentInitiation.RecipientAddress{
         street: [
           "96 Guild Street",
           "9th Floor"
         ],
         city: "London",
         postal_code: "SE14 8JW",
         country: "GB"
       },
       request_id: "4zlKapIkTm8p5KM"
     }} =
      Plaid.PaymentInitiation.get_recipient(
        "recipient-id-sandbox-9b6b4679-914b-445b-9450-efbdb80296f6",
        test_api_host: api_host,
        client_id: "123",
        secret: "abc"
      )
  end

  test "/payment_initiation/recipient/list", %{bypass: bypass, api_host: api_host} do
    Bypass.expect_once(bypass, "POST", "/payment_initiation/recipient/list", fn conn ->
      Conn.resp(conn, 200, ~s<{
        "recipients": [
          {
            "recipient_id": "recipient-id-sandbox-9b6b4679-914b-445b-9450-efbdb80296f6",
            "name": "Wonder Wallet",
            "iban": "GB29NWBK60161331926819",
            "address": {
              "street": [
                "96 Guild Street",
                "9th Floor"
              ],
              "city": "London",
              "postal_code": "SE14 8JW",
              "country": "GB"
            }
          }
        ],
        "request_id": "4zlKapIkTm8p5KM"
      }>)
    end)

    {:ok,
     %Plaid.PaymentInitiation.ListRecipientsResponse{
       recipients: [
         %Plaid.PaymentInitiation.Recipient{
           recipient_id: "recipient-id-sandbox-9b6b4679-914b-445b-9450-efbdb80296f6",
           name: "Wonder Wallet",
           iban: "GB29NWBK60161331926819",
           address: %Plaid.PaymentInitiation.RecipientAddress{
             street: [
               "96 Guild Street",
               "9th Floor"
             ],
             city: "London",
             postal_code: "SE14 8JW",
             country: "GB"
           }
         }
       ],
       request_id: "4zlKapIkTm8p5KM"
     }} =
      Plaid.PaymentInitiation.list_recipients(
        test_api_host: api_host,
        client_id: "123",
        secret: "abc"
      )
  end
end
