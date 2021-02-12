defmodule Plaid.InvestmentsTest do
  use ExUnit.Case
  use ExUnit.Case, async: true

  alias Plug.Conn

  setup do
    bypass = Bypass.open()
    api_host = "http://localhost:#{bypass.port}/"
    {:ok, bypass: bypass, api_host: api_host}
  end

  test "POST /investments/holdings/get", %{bypass: bypass, api_host: api_host} do
    Bypass.expect_once(bypass, "POST", "/investments/holdings/get", fn conn ->
      Conn.resp(conn, 200, ~s<{
        "accounts": [
          {
            "account_id": "5Bvpj4QknlhVWk7GygpwfVKdd133GoCxB814g",
            "balances": {
              "available": 43200,
              "current": 43200,
              "iso_currency_code": "USD",
              "limit": null,
              "unofficial_currency_code": null
            },
            "mask": "4444",
            "name": "Plaid Money Market",
            "official_name": "Plaid Platinum Standard 1.85% Interest Money Market",
            "subtype": "money market",
            "type": "depository"
          },
          {
            "account_id": "JqMLm4rJwpF6gMPJwBqdh9ZjjPvvpDcb7kDK1",
            "balances": {
              "available": null,
              "current": 320.76,
              "iso_currency_code": "USD",
              "limit": null,
              "unofficial_currency_code": null
            },
            "mask": "5555",
            "name": "Plaid IRA",
            "official_name": null,
            "subtype": "ira",
            "type": "investment"
          },
          {
            "account_id": "k67E4xKvMlhmleEa4pg9hlwGGNnnEeixPolGm",
            "balances": {
              "available": null,
              "current": 23631.9805,
              "iso_currency_code": "USD",
              "limit": null,
              "unofficial_currency_code": null
            },
            "mask": "6666",
            "name": "Plaid 401k",
            "official_name": null,
            "subtype": "401k",
            "type": "investment"
          }
        ],
        "holdings": [
          {
            "account_id": "JqMLm4rJwpF6gMPJwBqdh9ZjjPvvpDcb7kDK1",
            "cost_basis": 1,
            "institution_price": 1,
            "institution_price_as_of": null,
            "institution_value": 0.01,
            "iso_currency_code": "USD",
            "quantity": 0.01,
            "security_id": "d6ePmbPxgWCWmMVv66q9iPV94n91vMtov5Are",
            "unofficial_currency_code": null
          },
          {
            "account_id": "k67E4xKvMlhmleEa4pg9hlwGGNnnEeixPolGm",
            "cost_basis": 1.5,
            "institution_price": 2.11,
            "institution_price_as_of": null,
            "institution_value": 2.11,
            "iso_currency_code": "USD",
            "quantity": 1,
            "security_id": "KDwjlXj1Rqt58dVvmzRguxJybmyQL8FgeWWAy",
            "unofficial_currency_code": null
          },
          {
            "account_id": "k67E4xKvMlhmleEa4pg9hlwGGNnnEeixPolGm",
            "cost_basis": 10,
            "institution_price": 10.42,
            "institution_price_as_of": null,
            "institution_value": 20.84,
            "iso_currency_code": "USD",
            "quantity": 2,
            "security_id": "NDVQrXQoqzt5v3bAe8qRt4A7mK7wvZCLEBBJk",
            "unofficial_currency_code": null
          },
          {
            "account_id": "JqMLm4rJwpF6gMPJwBqdh9ZjjPvvpDcb7kDK1",
            "cost_basis": 0.01,
            "institution_price": 0.011,
            "institution_price_as_of": null,
            "institution_value": 110,
            "iso_currency_code": "USD",
            "quantity": 10000,
            "security_id": "8E4L9XLl6MudjEpwPAAgivmdZRdBPJuvMPlPb",
            "unofficial_currency_code": null
          },
          {
            "account_id": "k67E4xKvMlhmleEa4pg9hlwGGNnnEeixPolGm",
            "cost_basis": 23,
            "institution_price": 27,
            "institution_price_as_of": null,
            "institution_value": 636.309,
            "iso_currency_code": "USD",
            "quantity": 23.567,
            "security_id": "JDdP7XPMklt5vwPmDN45t3KAoWAPmjtpaW7DP",
            "unofficial_currency_code": null
          },
          {
            "account_id": "k67E4xKvMlhmleEa4pg9hlwGGNnnEeixPolGm",
            "cost_basis": 15,
            "institution_price": 13.73,
            "institution_price_as_of": null,
            "institution_value": 1373.6865,
            "iso_currency_code": "USD",
            "quantity": 100.05,
            "security_id": "nnmo8doZ4lfKNEDe3mPJipLGkaGw3jfPrpxoN",
            "unofficial_currency_code": null
          },
          {
            "account_id": "k67E4xKvMlhmleEa4pg9hlwGGNnnEeixPolGm",
            "cost_basis": 1,
            "institution_price": 1,
            "institution_price_as_of": null,
            "institution_value": 12345.67,
            "iso_currency_code": "USD",
            "quantity": 12345.67,
            "security_id": "d6ePmbPxgWCWmMVv66q9iPV94n91vMtov5Are",
            "unofficial_currency_code": null
          }
        ],
        "item": {
          "available_products": [
            "balance",
            "identity",
            "liabilities",
            "transactions"
          ],
          "billed_products": [
            "assets",
            "auth",
            "investments"
          ],
          "consent_expiration_time": null,
          "error": null,
          "institution_id": "ins_3",
          "item_id": "4z9LPae1nRHWy8pvg9jrsgbRP4ZNQvIdbLq7g",
          "webhook": "https://www.genericwebhookurl.com/webhook"
        },
        "request_id": "l68wb8zpS0hqmsJ",
        "securities": [
          {
            "close_price": 0.011,
            "close_price_as_of": null,
            "cusip": null,
            "institution_id": null,
            "institution_security_id": null,
            "is_cash_equivalent": false,
            "isin": null,
            "iso_currency_code": "USD",
            "name": "Nflx Feb 01'18 $355 Call",
            "proxy_security_id": null,
            "security_id": "8E4L9XLl6MudjEpwPAAgivmdZRdBPJuvMPlPb",
            "sedol": null,
            "ticker_symbol": "NFLX180201C00355000",
            "type": "derivative",
            "unofficial_currency_code": null
          },
          {
            "close_price": 27,
            "close_price_as_of": null,
            "cusip": "577130834",
            "institution_id": null,
            "institution_security_id": null,
            "is_cash_equivalent": false,
            "isin": "US5771308344",
            "iso_currency_code": "USD",
            "name": "Matthews Pacific Tiger Fund Insti Class",
            "proxy_security_id": null,
            "security_id": "JDdP7XPMklt5vwPmDN45t3KAoWAPmjtpaW7DP",
            "sedol": null,
            "ticker_symbol": "MIPTX",
            "type": "mutual fund",
            "unofficial_currency_code": null
          },
          {
            "close_price": 2.11,
            "close_price_as_of": null,
            "cusip": "00448Q201",
            "institution_id": null,
            "institution_security_id": null,
            "is_cash_equivalent": false,
            "isin": "US00448Q2012",
            "iso_currency_code": "USD",
            "name": "Achillion Pharmaceuticals Inc.",
            "proxy_security_id": null,
            "security_id": "KDwjlXj1Rqt58dVvmzRguxJybmyQL8FgeWWAy",
            "sedol": null,
            "ticker_symbol": "ACHN",
            "type": "equity",
            "unofficial_currency_code": null
          },
          {
            "close_price": 10.42,
            "close_price_as_of": null,
            "cusip": "258620103",
            "institution_id": null,
            "institution_security_id": null,
            "is_cash_equivalent": false,
            "isin": "US2586201038",
            "iso_currency_code": "USD",
            "name": "DoubleLine Total Return Bond Fund",
            "proxy_security_id": null,
            "security_id": "NDVQrXQoqzt5v3bAe8qRt4A7mK7wvZCLEBBJk",
            "sedol": null,
            "ticker_symbol": "DBLTX",
            "type": "mutual fund",
            "unofficial_currency_code": null
          },
          {
            "close_price": 1,
            "close_price_as_of": null,
            "cusip": null,
            "institution_id": null,
            "institution_security_id": null,
            "is_cash_equivalent": true,
            "isin": null,
            "iso_currency_code": "USD",
            "name": "U S Dollar",
            "proxy_security_id": null,
            "security_id": "d6ePmbPxgWCWmMVv66q9iPV94n91vMtov5Are",
            "sedol": null,
            "ticker_symbol": "USD",
            "type": "cash",
            "unofficial_currency_code": null
          },
          {
            "close_price": 13.73,
            "close_price_as_of": null,
            "cusip": null,
            "institution_id": "ins_3",
            "institution_security_id": "NHX105509",
            "is_cash_equivalent": false,
            "isin": null,
            "iso_currency_code": "USD",
            "name": "NH PORTFOLIO 1055 (FIDELITY INDEX)",
            "proxy_security_id": null,
            "security_id": "nnmo8doZ4lfKNEDe3mPJipLGkaGw3jfPrpxoN",
            "sedol": null,
            "ticker_symbol": "NHX105509",
            "type": "etf",
            "unofficial_currency_code": null
          }
        ]
      }>)
    end)

    {:ok,
     %Plaid.Investments.GetHoldingsResponse{
       accounts: [
         %Plaid.Accounts.Account{
           account_id: "5Bvpj4QknlhVWk7GygpwfVKdd133GoCxB814g",
           balances: %Plaid.Accounts.Account.Balances{
             available: 43200,
             current: 43200,
             iso_currency_code: "USD",
             limit: nil,
             unofficial_currency_code: nil
           },
           mask: "4444",
           name: "Plaid Money Market",
           official_name: "Plaid Platinum Standard 1.85% Interest Money Market",
           subtype: "money market",
           type: "depository"
         },
         %Plaid.Accounts.Account{
           account_id: "JqMLm4rJwpF6gMPJwBqdh9ZjjPvvpDcb7kDK1",
           balances: %Plaid.Accounts.Account.Balances{
             available: nil,
             current: 320.76,
             iso_currency_code: "USD",
             limit: nil,
             unofficial_currency_code: nil
           },
           mask: "5555",
           name: "Plaid IRA",
           official_name: nil,
           subtype: "ira",
           type: "investment"
         },
         %Plaid.Accounts.Account{
           account_id: "k67E4xKvMlhmleEa4pg9hlwGGNnnEeixPolGm",
           balances: %Plaid.Accounts.Account.Balances{
             available: nil,
             current: 23631.9805,
             iso_currency_code: "USD",
             limit: nil,
             unofficial_currency_code: nil
           },
           mask: "6666",
           name: "Plaid 401k",
           official_name: nil,
           subtype: "401k",
           type: "investment"
         }
       ],
       holdings: [
         %Plaid.Investments.Holding{
           account_id: "JqMLm4rJwpF6gMPJwBqdh9ZjjPvvpDcb7kDK1",
           cost_basis: 1,
           institution_price: 1,
           institution_price_as_of: nil,
           institution_value: 0.01,
           iso_currency_code: "USD",
           quantity: 0.01,
           security_id: "d6ePmbPxgWCWmMVv66q9iPV94n91vMtov5Are",
           unofficial_currency_code: nil
         },
         %Plaid.Investments.Holding{
           account_id: "k67E4xKvMlhmleEa4pg9hlwGGNnnEeixPolGm",
           cost_basis: 1.5,
           institution_price: 2.11,
           institution_price_as_of: nil,
           institution_value: 2.11,
           iso_currency_code: "USD",
           quantity: 1,
           security_id: "KDwjlXj1Rqt58dVvmzRguxJybmyQL8FgeWWAy",
           unofficial_currency_code: nil
         },
         %Plaid.Investments.Holding{
           account_id: "k67E4xKvMlhmleEa4pg9hlwGGNnnEeixPolGm",
           cost_basis: 10,
           institution_price: 10.42,
           institution_price_as_of: nil,
           institution_value: 20.84,
           iso_currency_code: "USD",
           quantity: 2,
           security_id: "NDVQrXQoqzt5v3bAe8qRt4A7mK7wvZCLEBBJk",
           unofficial_currency_code: nil
         },
         %Plaid.Investments.Holding{
           account_id: "JqMLm4rJwpF6gMPJwBqdh9ZjjPvvpDcb7kDK1",
           cost_basis: 0.01,
           institution_price: 0.011,
           institution_price_as_of: nil,
           institution_value: 110,
           iso_currency_code: "USD",
           quantity: 10000,
           security_id: "8E4L9XLl6MudjEpwPAAgivmdZRdBPJuvMPlPb",
           unofficial_currency_code: nil
         },
         %Plaid.Investments.Holding{
           account_id: "k67E4xKvMlhmleEa4pg9hlwGGNnnEeixPolGm",
           cost_basis: 23,
           institution_price: 27,
           institution_price_as_of: nil,
           institution_value: 636.309,
           iso_currency_code: "USD",
           quantity: 23.567,
           security_id: "JDdP7XPMklt5vwPmDN45t3KAoWAPmjtpaW7DP",
           unofficial_currency_code: nil
         },
         %Plaid.Investments.Holding{
           account_id: "k67E4xKvMlhmleEa4pg9hlwGGNnnEeixPolGm",
           cost_basis: 15,
           institution_price: 13.73,
           institution_price_as_of: nil,
           institution_value: 1373.6865,
           iso_currency_code: "USD",
           quantity: 100.05,
           security_id: "nnmo8doZ4lfKNEDe3mPJipLGkaGw3jfPrpxoN",
           unofficial_currency_code: nil
         },
         %Plaid.Investments.Holding{
           account_id: "k67E4xKvMlhmleEa4pg9hlwGGNnnEeixPolGm",
           cost_basis: 1,
           institution_price: 1,
           institution_price_as_of: nil,
           institution_value: 12345.67,
           iso_currency_code: "USD",
           quantity: 12345.67,
           security_id: "d6ePmbPxgWCWmMVv66q9iPV94n91vMtov5Are",
           unofficial_currency_code: nil
         }
       ],
       item: %Plaid.Item{
         available_products: [
           "balance",
           "identity",
           "liabilities",
           "transactions"
         ],
         billed_products: [
           "assets",
           "auth",
           "investments"
         ],
         consent_expiration_time: nil,
         error: nil,
         institution_id: "ins_3",
         item_id: "4z9LPae1nRHWy8pvg9jrsgbRP4ZNQvIdbLq7g",
         webhook: "https://www.genericwebhookurl.com/webhook"
       },
       request_id: "l68wb8zpS0hqmsJ",
       securities: [
         %Plaid.Investments.Security{
           close_price: 0.011,
           close_price_as_of: nil,
           cusip: nil,
           institution_id: nil,
           institution_security_id: nil,
           is_cash_equivalent: false,
           isin: nil,
           iso_currency_code: "USD",
           name: "Nflx Feb 01'18 $355 Call",
           proxy_security_id: nil,
           security_id: "8E4L9XLl6MudjEpwPAAgivmdZRdBPJuvMPlPb",
           sedol: nil,
           ticker_symbol: "NFLX180201C00355000",
           type: "derivative",
           unofficial_currency_code: nil
         },
         %Plaid.Investments.Security{
           close_price: 27,
           close_price_as_of: nil,
           cusip: "577130834",
           institution_id: nil,
           institution_security_id: nil,
           is_cash_equivalent: false,
           isin: "US5771308344",
           iso_currency_code: "USD",
           name: "Matthews Pacific Tiger Fund Insti Class",
           proxy_security_id: nil,
           security_id: "JDdP7XPMklt5vwPmDN45t3KAoWAPmjtpaW7DP",
           sedol: nil,
           ticker_symbol: "MIPTX",
           type: "mutual fund",
           unofficial_currency_code: nil
         },
         %Plaid.Investments.Security{
           close_price: 2.11,
           close_price_as_of: nil,
           cusip: "00448Q201",
           institution_id: nil,
           institution_security_id: nil,
           is_cash_equivalent: false,
           isin: "US00448Q2012",
           iso_currency_code: "USD",
           name: "Achillion Pharmaceuticals Inc.",
           proxy_security_id: nil,
           security_id: "KDwjlXj1Rqt58dVvmzRguxJybmyQL8FgeWWAy",
           sedol: nil,
           ticker_symbol: "ACHN",
           type: "equity",
           unofficial_currency_code: nil
         },
         %Plaid.Investments.Security{
           close_price: 10.42,
           close_price_as_of: nil,
           cusip: "258620103",
           institution_id: nil,
           institution_security_id: nil,
           is_cash_equivalent: false,
           isin: "US2586201038",
           iso_currency_code: "USD",
           name: "DoubleLine Total Return Bond Fund",
           proxy_security_id: nil,
           security_id: "NDVQrXQoqzt5v3bAe8qRt4A7mK7wvZCLEBBJk",
           sedol: nil,
           ticker_symbol: "DBLTX",
           type: "mutual fund",
           unofficial_currency_code: nil
         },
         %Plaid.Investments.Security{
           close_price: 1,
           close_price_as_of: nil,
           cusip: nil,
           institution_id: nil,
           institution_security_id: nil,
           is_cash_equivalent: true,
           isin: nil,
           iso_currency_code: "USD",
           name: "U S Dollar",
           proxy_security_id: nil,
           security_id: "d6ePmbPxgWCWmMVv66q9iPV94n91vMtov5Are",
           sedol: nil,
           ticker_symbol: "USD",
           type: "cash",
           unofficial_currency_code: nil
         },
         %Plaid.Investments.Security{
           close_price: 13.73,
           close_price_as_of: nil,
           cusip: nil,
           institution_id: "ins_3",
           institution_security_id: "NHX105509",
           is_cash_equivalent: false,
           isin: nil,
           iso_currency_code: "USD",
           name: "NH PORTFOLIO 1055 (FIDELITY INDEX)",
           proxy_security_id: nil,
           security_id: "nnmo8doZ4lfKNEDe3mPJipLGkaGw3jfPrpxoN",
           sedol: nil,
           ticker_symbol: "NHX105509",
           type: "etf",
           unofficial_currency_code: nil
         }
       ]
     }} =
      Plaid.Investments.get_holdings(
        "access-prod-123xxx",
        %{account_ids: ["5Bvpj4QknlhVWk7GygpwfVKdd133GoCxB814g"]},
        test_api_host: api_host,
        client_id: "123",
        secret: "abc"
      )
  end
end
