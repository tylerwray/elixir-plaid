%Plaid.Accounts{
  accounts: [
    %Plaid.Accounts.Account{
      account_id: "blgvvBlXw3cq5GMPwqB6s6q4dLKB9WcVqGDGo",
      balances: %Plaid.Accounts.Account.Balances{
        available: 100,
        current: 110,
        iso_currency_code: "USD",
        limit: nil,
        unofficial_currency_code: nil
      },
      item: nil,
      mask: "0000",
      name: "Plaid Checking",
      official_name: "Plaid Gold Standard 0% Interest Checking",
      subtype: "checking",
      type: "depository",
      verification_status: nil
    },
    %Plaid.Accounts.Account{
      account_id: "6PdjjRP6LmugpBy5NgQvUqpRXMWxzktg3rwrk",
      balances: %Plaid.Accounts.Account.Balances{
        available: nil,
        current: 23631.9805,
        iso_currency_code: "USD",
        limit: nil,
        unofficial_currency_code: nil
      },
      item: nil,
      mask: "6666",
      name: "Plaid 401k",
      official_name: nil,
      subtype: "401k",
      type: "investment",
      verification_status: nil
    },
    %Plaid.Accounts.Account{
      account_id: "XMBvvyMGQ1UoLbKByoMqH3nXMj84ALSdE5B58",
      balances: %Plaid.Accounts.Account.Balances{
        available: nil,
        current: 65262,
        iso_currency_code: "USD",
        limit: nil,
        unofficial_currency_code: nil
      },
      item: nil,
      mask: "7777",
      name: "Plaid Student Loan",
      official_name: nil,
      subtype: "student",
      type: "loan",
      verification_status: nil
    }
  ],
  item: %Plaid.Item{
    available_products: ["balance", "identity", "payment_initiation", "transactions"],
    billed_products: ["assets", "auth"],
    consent_expiration_time: nil,
    error: nil,
    institution_id: "ins_117650",
    item_id: "DWVAAPWq4RHGlEaNyGKRTAnPLaEmo8Cvq7na6",
    webhook: "https://www.genericwebhookurl.com/webhook"
  },
  request_id: "bkVE1BHWMAZ9Rnr"
}
