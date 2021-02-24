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
          address: %Plaid.PaymentInitiation.Address{
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
       address: %Plaid.PaymentInitiation.Address{
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
           address: %Plaid.PaymentInitiation.Address{
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

  test "/payment_initiation/payment/create", %{bypass: bypass, api_host: api_host} do
    Bypass.expect_once(bypass, "POST", "/payment_initiation/payment/create", fn conn ->
      Conn.resp(conn, 200, ~s<{
        "payment_id": "payment-id-sandbox-feca8a7a-5591-4aef-9297-f3062bb735d3",
        "status": "PAYMENT_STATUS_INPUT_NEEDED",
        "request_id": "4ciYVmesrySiUAB"
      }>)
    end)

    {:ok,
     %Plaid.PaymentInitiation.CreatePaymentResponse{
       payment_id: "payment-id-sandbox-feca8a7a-5591-4aef-9297-f3062bb735d3",
       status: "PAYMENT_STATUS_INPUT_NEEDED",
       request_id: "4ciYVmesrySiUAB"
     }} =
      Plaid.PaymentInitiation.create_payment(
        "recipient-id-sandbox-9b6b4679-914b-445b-9450-efbdb80296f6",
        "Account Funding 99744",
        %Plaid.PaymentInitiation.Amount{
          currency: "GBP",
          value: 100
        },
        %{
          schedule: %Plaid.PaymentInitiation.Schedule{
            interval: "WEEKLY",
            interval_execution_day: 2,
            start_date: "2021-01-01",
            end_date: "2021-01-31"
          }
        },
        test_api_host: api_host,
        client_id: "123",
        secret: "abc"
      )
  end

  test "/payment_initiation/payment/get", %{bypass: bypass, api_host: api_host} do
    Bypass.expect_once(bypass, "POST", "/payment_initiation/payment/get", fn conn ->
      Conn.resp(conn, 200, ~s<{
        "payment_id": "payment-id-sandbox-feca8a7a-5591-4aef-9297-f3062bb735d3",
        "payment_token": "payment-token-sandbox-c6a26505-42b4-46fe-8ecf-bf9edcafbebb",
        "reference": "Account Funding 99744",
        "amount": {
          "currency": "GBP",
          "value": 100
        },
        "status": "PAYMENT_STATUS_INPUT_NEEDED",
        "last_status_update": "2019-11-06T21:10:52Z",
        "payment_expiration_time": "2019-11-06T21:25:52Z",
        "recipient_id": "recipient-id-sandbox-9b6b4679-914b-445b-9450-efbdb80296f6",
        "request_id": "aEAQmewMzlVa1k6"
      }>)
    end)

    {:ok,
     %Plaid.PaymentInitiation.GetPaymentResponse{
       payment_id: "payment-id-sandbox-feca8a7a-5591-4aef-9297-f3062bb735d3",
       payment_token: "payment-token-sandbox-c6a26505-42b4-46fe-8ecf-bf9edcafbebb",
       reference: "Account Funding 99744",
       amount: %Plaid.PaymentInitiation.Amount{
         currency: "GBP",
         value: 100
       },
       status: "PAYMENT_STATUS_INPUT_NEEDED",
       last_status_update: "2019-11-06T21:10:52Z",
       payment_expiration_time: "2019-11-06T21:25:52Z",
       recipient_id: "recipient-id-sandbox-9b6b4679-914b-445b-9450-efbdb80296f6",
       request_id: "aEAQmewMzlVa1k6"
     }} =
      Plaid.PaymentInitiation.get_payment(
        "payment-id-sandbox-feca8a7a-5591-4aef-9297-f3062bb735d3",
        test_api_host: api_host,
        client_id: "123",
        secret: "abc"
      )
  end

  test "/payment_initiation/payment/list", %{bypass: bypass, api_host: api_host} do
    Bypass.expect_once(bypass, "POST", "/payment_initiation/payment/list", fn conn ->
      Conn.resp(conn, 200, ~s<{
        "payments": [
          {
            "payment_id": "payment-id-sandbox-feca8a7a-5591-4aef-9297-f3062bb735d3",
            "reference": "Account Funding 99744",
            "amount": {
              "currency": "GBP",
              "value": 100
            },
            "status": "PAYMENT_STATUS_INPUT_NEEDED",
            "last_status_update": "2019-11-06T21:10:52Z",
            "recipient_id": "recipient-id-sandbox-9b6b4679-914b-445b-9450-efbdb80296f6",
            "schedule": {
              "interval": "WEEKLY",
              "interval_execution_day": 2,
              "start_date": "2021-01-01",
              "end_date": "2021-01-31"
            }
          }
        ],
        "next_cursor": "2020-01-01T00:00:00Z",
        "request_id": "aEAQmewMzlVa1k6"
      }>)
    end)

    {:ok,
     %Plaid.PaymentInitiation.ListPaymentsResponse{
       payments: [
         %Plaid.PaymentInitiation.Payment{
           payment_id: "payment-id-sandbox-feca8a7a-5591-4aef-9297-f3062bb735d3",
           reference: "Account Funding 99744",
           amount: %Plaid.PaymentInitiation.Amount{
             currency: "GBP",
             value: 100
           },
           status: "PAYMENT_STATUS_INPUT_NEEDED",
           last_status_update: "2019-11-06T21:10:52Z",
           recipient_id: "recipient-id-sandbox-9b6b4679-914b-445b-9450-efbdb80296f6",
           schedule: %Plaid.PaymentInitiation.Schedule{
             interval: "WEEKLY",
             interval_execution_day: 2,
             start_date: "2021-01-01",
             end_date: "2021-01-31"
           }
         }
       ],
       next_cursor: "2020-01-01T00:00:00Z",
       request_id: "aEAQmewMzlVa1k6"
     }} =
      Plaid.PaymentInitiation.list_payments(
        %{count: 1, cursor: "2020-01-01T00:00:00Z"},
        test_api_host: api_host,
        client_id: "123",
        secret: "abc"
      )
  end
end
