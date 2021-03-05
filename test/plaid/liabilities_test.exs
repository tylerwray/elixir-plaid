defmodule Plaid.LiabilitiesTest do
  use ExUnit.Case, async: true

  alias Plug.Conn

  setup do
    bypass = Bypass.open()
    api_host = "http://localhost:#{bypass.port}/"
    {:ok, bypass: bypass, api_host: api_host}
  end

  test "/liabilities/get", %{bypass: bypass, api_host: api_host} do
    Bypass.expect_once(bypass, "POST", "/liabilities/get", fn conn ->
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
            "subtype": "checking",
            "type": "depository"
          },
          {
            "account_id": "dVzbVMLjrxTnLjX4G66XUp5GLklm4oiZy88yK",
            "balances": {
              "available": null,
              "current": 410,
              "iso_currency_code": "USD",
              "limit": 2000,
              "unofficial_currency_code": null
            },
            "mask": "3333",
            "name": "Plaid Credit Card",
            "official_name": "Plaid Diamond 12.5% APR Interest Credit Card",
            "subtype": "credit card",
            "type": "credit"
          },
          {
            "account_id": "Pp1Vpkl9w8sajvK6oEEKtr7vZxBnGpf7LxxLE",
            "balances": {
              "available": null,
              "current": 65262,
              "iso_currency_code": "USD",
              "limit": null,
              "unofficial_currency_code": null
            },
            "mask": "7777",
            "name": "Plaid Student Loan",
            "official_name": null,
            "subtype": "student",
            "type": "loan"
          },
          {
            "account_id": "BxBXxLj1m4HMXBm9WZJyUg9XLd4rKEhw8Pb1J",
            "balances": {
              "available": null,
              "current": 56302.06,
              "iso_currency_code": "USD",
              "limit": null,
              "unofficial_currency_code": null
            },
            "mask": "8888",
            "name": "Plaid Mortgage",
            "official_name": null,
            "subtype": "mortgage",
            "type": "loan"
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
        "liabilities": {
          "credit": [
            {
              "account_id": "dVzbVMLjrxTnLjX4G66XUp5GLklm4oiZy88yK",
              "aprs": [
                {
                  "apr_percentage": 15.24,
                  "apr_type": "balance_transfer_apr",
                  "balance_subject_to_apr": 1562.32,
                  "interest_charge_amount": 130.22
                },
                {
                  "apr_percentage": 27.95,
                  "apr_type": "cash_apr",
                  "balance_subject_to_apr": 56.22,
                  "interest_charge_amount": 14.81
                },
                {
                  "apr_percentage": 12.5,
                  "apr_type": "purchase_apr",
                  "balance_subject_to_apr": 157.01,
                  "interest_charge_amount": 25.66
                },
                {
                  "apr_percentage": 0,
                  "apr_type": "special",
                  "balance_subject_to_apr": 1000,
                  "interest_charge_amount": 0
                }
              ],
              "is_overdue": false,
              "last_payment_amount": 168.25,
              "last_payment_date": "2019-05-22",
              "last_statement_balance": 1708.77,
              "last_statement_issue_date": "2019-05-28",
              "minimum_payment_amount": 20,
              "next_payment_due_date": "2020-05-28"
            }
          ],
          "mortgage": [
            {
              "account_id": "BxBXxLj1m4HMXBm9WZJyUg9XLd4rKEhw8Pb1J",
              "account_number": "3120194154",
              "current_late_fee": 25,
              "escrow_balance": 3141.54,
              "has_pmi": true,
              "has_prepayment_penalty": true,
              "interest_rate": {
                "percentage": 3.99,
                "type": "fixed"
              },
              "last_payment_amount": 3141.54,
              "last_payment_date": "2019-08-01",
              "loan_term": "30 year",
              "loan_type_description": "conventional",
              "maturity_date": "2045-07-31",
              "next_monthly_payment": 3141.54,
              "next_payment_due_date": "2019-11-15",
              "origination_date": "2015-08-01",
              "origination_principal_amount": 425000,
              "past_due_amount": 2304,
              "property_address": {
                "city": "Malakoff",
                "country": "US",
                "postal_code": "14236",
                "region": "NY",
                "street": "2992 Cameron Road"
              },
              "ytd_interest_paid": 12300.4,
              "ytd_principal_paid": 12340.5
            }
          ],
          "student": [
            {
              "account_id": "Pp1Vpkl9w8sajvK6oEEKtr7vZxBnGpf7LxxLE",
              "account_number": "4277075694",
              "disbursement_dates": [
                "2002-08-28"
              ],
              "expected_payoff_date": "2032-07-28",
              "guarantor": "DEPT OF ED",
              "interest_rate_percentage": 5.25,
              "is_overdue": false,
              "last_payment_amount": 138.05,
              "last_payment_date": "2019-04-22",
              "last_statement_balance": 138.05,
              "last_statement_issue_date": "2019-04-28",
              "loan_name": "Consolidation",
              "loan_status": {
                "end_date": "2032-07-28",
                "type": "repayment"
              },
              "minimum_payment_amount": 25,
              "next_payment_due_date": "2019-05-28",
              "origination_date": "2002-08-28",
              "origination_principal_amount": 25000,
              "outstanding_interest_amount": 6227.36,
              "payment_reference_number": "4277075694",
              "pslf_status": {
                "estimated_eligibility_date": "2021-01-01",
                "payments_made": 200,
                "payments_remaining": 160
              },
              "repayment_plan": {
                "description": "Standard Repayment",
                "type": "standard"
              },
              "sequence_number": "1",
              "servicer_address": {
                "city": "San Matias",
                "country": "US",
                "postal_code": "99415",
                "region": "CA",
                "street": "123 Relaxation Road"
              },
              "ytd_interest_paid": 280.55,
              "ytd_principal_paid": 271.65
            }
          ]
        },
        "request_id": "dTnnm60WgKGLnKL"
      }>)
    end)

    {:ok,
     %Plaid.Liabilities.GetResponse{
       accounts: [
         %Plaid.Accounts.Account{
           account_id: "BxBXxLj1m4HMXBm9WZZmCWVbPjX16EHwv99vp",
           balances: %Plaid.Accounts.Account.Balances{
             available: 100,
             current: 110,
             iso_currency_code: "USD",
             limit: nil,
             unofficial_currency_code: nil
           },
           mask: "0000",
           name: "Plaid Checking",
           official_name: "Plaid Gold Standard 0% Interest Checking",
           subtype: "checking",
           type: "depository"
         },
         %Plaid.Accounts.Account{
           account_id: "dVzbVMLjrxTnLjX4G66XUp5GLklm4oiZy88yK",
           balances: %Plaid.Accounts.Account.Balances{
             available: nil,
             current: 410,
             iso_currency_code: "USD",
             limit: 2000,
             unofficial_currency_code: nil
           },
           mask: "3333",
           name: "Plaid Credit Card",
           official_name: "Plaid Diamond 12.5% APR Interest Credit Card",
           subtype: "credit card",
           type: "credit"
         },
         %Plaid.Accounts.Account{
           account_id: "Pp1Vpkl9w8sajvK6oEEKtr7vZxBnGpf7LxxLE",
           balances: %Plaid.Accounts.Account.Balances{
             available: nil,
             current: 65_262,
             iso_currency_code: "USD",
             limit: nil,
             unofficial_currency_code: nil
           },
           mask: "7777",
           name: "Plaid Student Loan",
           official_name: nil,
           subtype: "student",
           type: "loan"
         },
         %Plaid.Accounts.Account{
           account_id: "BxBXxLj1m4HMXBm9WZJyUg9XLd4rKEhw8Pb1J",
           balances: %Plaid.Accounts.Account.Balances{
             available: nil,
             current: 56_302.06,
             iso_currency_code: "USD",
             limit: nil,
             unofficial_currency_code: nil
           },
           mask: "8888",
           name: "Plaid Mortgage",
           official_name: nil,
           subtype: "mortgage",
           type: "loan"
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
       liabilities: %Plaid.Liabilities{
         credit: [
           %Plaid.Liabilities.Credit{
             account_id: "dVzbVMLjrxTnLjX4G66XUp5GLklm4oiZy88yK",
             aprs: [
               %Plaid.Liabilities.Credit.APR{
                 apr_percentage: 15.24,
                 apr_type: "balance_transfer_apr",
                 balance_subject_to_apr: 1562.32,
                 interest_charge_amount: 130.22
               },
               %Plaid.Liabilities.Credit.APR{
                 apr_percentage: 27.95,
                 apr_type: "cash_apr",
                 balance_subject_to_apr: 56.22,
                 interest_charge_amount: 14.81
               },
               %Plaid.Liabilities.Credit.APR{
                 apr_percentage: 12.5,
                 apr_type: "purchase_apr",
                 balance_subject_to_apr: 157.01,
                 interest_charge_amount: 25.66
               },
               %Plaid.Liabilities.Credit.APR{
                 apr_percentage: 0,
                 apr_type: "special",
                 balance_subject_to_apr: 1000,
                 interest_charge_amount: 0
               }
             ],
             is_overdue: false,
             last_payment_amount: 168.25,
             last_payment_date: "2019-05-22",
             last_statement_balance: 1708.77,
             last_statement_issue_date: "2019-05-28",
             minimum_payment_amount: 20,
             next_payment_due_date: "2020-05-28"
           }
         ],
         mortgage: [
           %Plaid.Liabilities.Mortgage{
             account_id: "BxBXxLj1m4HMXBm9WZJyUg9XLd4rKEhw8Pb1J",
             account_number: "3120194154",
             current_late_fee: 25,
             escrow_balance: 3141.54,
             has_pmi: true,
             has_prepayment_penalty: true,
             interest_rate: %Plaid.Liabilities.Mortgage.InterestRate{
               percentage: 3.99,
               type: "fixed"
             },
             last_payment_amount: 3141.54,
             last_payment_date: "2019-08-01",
             loan_term: "30 year",
             loan_type_description: "conventional",
             maturity_date: "2045-07-31",
             next_monthly_payment: 3141.54,
             next_payment_due_date: "2019-11-15",
             origination_date: "2015-08-01",
             origination_principal_amount: 425_000,
             past_due_amount: 2304,
             property_address: %Plaid.Address{
               city: "Malakoff",
               country: "US",
               postal_code: "14236",
               region: "NY",
               street: "2992 Cameron Road"
             },
             ytd_interest_paid: 12_300.4,
             ytd_principal_paid: 12_340.5
           }
         ],
         student: [
           %Plaid.Liabilities.Student{
             account_id: "Pp1Vpkl9w8sajvK6oEEKtr7vZxBnGpf7LxxLE",
             account_number: "4277075694",
             disbursement_dates: [
               "2002-08-28"
             ],
             expected_payoff_date: "2032-07-28",
             guarantor: "DEPT OF ED",
             interest_rate_percentage: 5.25,
             is_overdue: false,
             last_payment_amount: 138.05,
             last_payment_date: "2019-04-22",
             last_statement_balance: 138.05,
             last_statement_issue_date: "2019-04-28",
             loan_name: "Consolidation",
             loan_status: %Plaid.Liabilities.Student.LoanStatus{
               end_date: "2032-07-28",
               type: "repayment"
             },
             minimum_payment_amount: 25,
             next_payment_due_date: "2019-05-28",
             origination_date: "2002-08-28",
             origination_principal_amount: 25_000,
             outstanding_interest_amount: 6227.36,
             payment_reference_number: "4277075694",
             pslf_status: %Plaid.Liabilities.Student.PSLFStatus{
               estimated_eligibility_date: "2021-01-01",
               payments_made: 200,
               payments_remaining: 160
             },
             repayment_plan: %Plaid.Liabilities.Student.RepaymentPlan{
               description: "Standard Repayment",
               type: "standard"
             },
             sequence_number: "1",
             servicer_address: %Plaid.Address{
               city: "San Matias",
               country: "US",
               postal_code: "99415",
               region: "CA",
               street: "123 Relaxation Road"
             },
             ytd_interest_paid: 280.55,
             ytd_principal_paid: 271.65
           }
         ]
       },
       request_id: "dTnnm60WgKGLnKL"
     }} =
      Plaid.Liabilities.get(
        "access-prod-123xxx",
        %{account_ids: ["BxBXxLj1m4HMXBm9WZZmCWVbPjX16EHwv99vp"]},
        test_api_host: api_host,
        client_id: "123",
        secret: "abc"
      )
  end
end
