defmodule Plaid.MixProject do
  use Mix.Project

  def project do
    [
      app: :elixir_plaid,
      version: "0.1.7",
      description: description(),
      package: package(),
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      source_url: "https://github.com/tylerwray/elixir-plaid",
      dialyzer: [
        plt_file: {:no_warn, "priv/plts/dialyzer.plt"}
      ],
      docs: [
        main: "readme",
        extras: ["README.md", "CONTRIBUTING.md", "guides/webhooks.md"],
        groups_for_modules: [
          Accounts: [
            Plaid.Accounts.Account,
            Plaid.Accounts.Account.Balances,
            Plaid.Accounts.Account.HistoricalBalances,
            Plaid.Accounts.GetResponse
          ],
          "Asset Report": [
            Plaid.AssetReport.AsyncResponse,
            Plaid.AssetReport.CreateAuditCopyResponse,
            Plaid.AssetReport.GetResponse,
            Plaid.AssetReport.RemoveAuditCopyResponse,
            Plaid.AssetReport.RemoveResponse,
            Plaid.AssetReport.Report,
            Plaid.AssetReport.Report.Item,
            Plaid.AssetReport.User,
            Plaid.AssetReport.Warning,
            Plaid.AssetReport.Warning.Cause
          ],
          Auth: [
            Plaid.Auth.GetResponse,
            Plaid.Auth.Numbers,
            Plaid.Auth.Numbers.ACH,
            Plaid.Auth.Numbers.BACS,
            Plaid.Auth.Numbers.EFT,
            Plaid.Auth.Numbers.International
          ],
          Categories: [
            Plaid.Categories.Category,
            Plaid.Categories.GetResponse
          ],
          Employer: [
            Plaid.Employer.SearchResponse
          ],
          Identity: [
            Plaid.Identity.Address,
            Plaid.Identity.AddressData,
            Plaid.Identity.Email,
            Plaid.Identity.GetResponse,
            Plaid.Identity.PhoneNumber
          ],
          Institutions: [
            Plaid.Institution,
            Plaid.Institution.Status,
            Plaid.Institution.Status.Auth,
            Plaid.Institution.Status.Balance,
            Plaid.Institution.Status.Breakdown,
            Plaid.Institution.Status.HealthIncident,
            Plaid.Institution.Status.HealthIncidentUpdate,
            Plaid.Institution.Status.Identity,
            Plaid.Institution.Status.InvestmentsUpdates,
            Plaid.Institution.Status.ItemLogins,
            Plaid.Institution.Status.TransactionsUpdates,
            Plaid.Institutions.GetByIdResponse,
            Plaid.Institutions.GetResponse,
            Plaid.Institutions.SearchResponse
          ],
          Investments: [
            Plaid.Investments.GetHoldingsResponse,
            Plaid.Investments.GetTransactionsResponse,
            Plaid.Investments.Holding,
            Plaid.Investments.Security,
            Plaid.Investments.Transaction
          ],
          Item: [
            Plaid.Item.GetResponse,
            Plaid.Item.Status,
            Plaid.Item.Status.Investments,
            Plaid.Item.Status.LastWebhook,
            Plaid.Item.Status.Transactions,
            Plaid.Item.UpdateWebhookResponse
          ],
          Liabilities: [
            Plaid.Liabilities.Credit,
            Plaid.Liabilities.Credit.APR,
            Plaid.Liabilities.GetResponse,
            Plaid.Liabilities.Mortgage,
            Plaid.Liabilities.Mortgage.InterestRate,
            Plaid.Liabilities.Student,
            Plaid.Liabilities.Student.LoanStatus,
            Plaid.Liabilities.Student.PSLFStatus,
            Plaid.Liabilities.Student.RepaymentPlan
          ],
          "Payment Initiation": [
            Plaid.PaymentInitiation.Address,
            Plaid.PaymentInitiation.Amount,
            Plaid.PaymentInitiation.BACS,
            Plaid.PaymentInitiation.CreatePaymentResponse,
            Plaid.PaymentInitiation.CreateRecipientResponse,
            Plaid.PaymentInitiation.GetPaymentResponse,
            Plaid.PaymentInitiation.GetRecipientResponse,
            Plaid.PaymentInitiation.ListPaymentsResponse,
            Plaid.PaymentInitiation.ListRecipientsResponse,
            Plaid.PaymentInitiation.Payment,
            Plaid.PaymentInitiation.Recipient,
            Plaid.PaymentInitiation.Schedule
          ],
          Processor: [
            Plaid.Processor.CreateStripeBankAccountTokenResponse,
            Plaid.Processor.CreateTokenResponse,
            Plaid.Processor.GetAuthResponse,
            Plaid.Processor.GetBalanceResponse,
            Plaid.Processor.GetIdentityResponse,
            Plaid.Processor.Numbers
          ],
          Transactions: [
            Plaid.Transactions.GetResponse,
            Plaid.Transactions.Transaction,
            Plaid.Transactions.Transaction.Location,
            Plaid.Transactions.Transaction.PaymentMeta
          ],
          Webhooks: [
            Plaid.Webhooks.AssetsError,
            Plaid.Webhooks.AssetsProductReady,
            Plaid.Webhooks.Auth,
            Plaid.Webhooks.HoldingsUpdate,
            Plaid.Webhooks.InvestmentsTransactionsUpdate,
            Plaid.Webhooks.ItemError,
            Plaid.Webhooks.ItemPendingExpiration,
            Plaid.Webhooks.ItemUserPermissionRevoked,
            Plaid.Webhooks.ItemWebhookUpdateAcknowledged,
            Plaid.Webhooks.TransactionsRemoved,
            Plaid.Webhooks.TransactionsUpdate,
            Plaid.Webhooks.PaymentInitiationPaymentStatusUpdate
          ],
          Other: [
            Plaid,
            Plaid.Address,
            Plaid.Error,
            Plaid.SimpleResponse
          ]
        ]
      ],
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:bypass, "~> 2.1", only: :test},
      {:credo, "~> 1.5", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false},
      {:ex_doc, "~> 0.23", only: :dev, runtime: false},
      {:httpoison, "~> 1.7"},
      {:jason, "~> 1.2"},
      {:joken, "~> 2.0"},
      {:secure_compare, "~> 0.1.0"}
    ]
  end

  defp description do
    "Simply Beautiful Elixir bindings for the Plaid API."
  end

  defp package do
    [
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/tylerwray/elixir-plaid"}
    ]
  end
end
