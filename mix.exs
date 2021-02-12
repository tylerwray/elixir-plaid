defmodule Plaid.MixProject do
  use Mix.Project

  def project do
    [
      app: :elixir_plaid,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      source_url: "https://github.com/tylerwray/elixir-plaid",
      docs: [
        main: "readme",
        extras: ["CONTRIBUTING.md", "README.md"],
        groups_for_modules: [
          Accounts: [
            Plaid.Accounts.Account,
            Plaid.Accounts.Account.Balances,
            Plaid.Accounts.Account.HistoricalBalances
          ],
          "Asset Report": [
            Plaid.AssetReport.AsyncResponse,
            Plaid.AssetReport.AuditCopyResponse,
            Plaid.AssetReport.GetResponse,
            Plaid.AssetReport.RemoveResponse,
            Plaid.AssetReport.Report,
            Plaid.AssetReport.Report.Item,
            Plaid.AssetReport.User,
            Plaid.AssetReport.Warning,
            Plaid.AssetReport.Warning.Cause
          ],
          Auth: [
            Plaid.Auth.Numbers,
            Plaid.Auth.Numbers.ACH,
            Plaid.Auth.Numbers.BACS,
            Plaid.Auth.Numbers.EFT,
            Plaid.Auth.Numbers.International
          ],
          Categories: [
            Plaid.Categories.Category
          ],
          Identity: [
            Plaid.Identity.Address,
            Plaid.Identity.AddressData,
            Plaid.Identity.Email,
            Plaid.Identity.PhoneNumber
          ],
          Investments: [
            Plaid.Investments.GetHoldingsResponse,
            Plaid.Investments.Holding,
            Plaid.Investments.Security
          ],
          Transactions: [
            Plaid.Transactions.Transaction,
            Plaid.Transactions.Transaction.Location,
            Plaid.Transactions.Transaction.PaymentMeta
          ],
          Other: [
            Plaid,
            Plaid.Error,
            Plaid.Item,
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
      extra_applications: [:logger],
      # Default Application environment
      env: [env: :sandbox]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:bypass, "~> 2.1", only: :test},
      {:credo, "~> 1.5", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.23", only: :dev, runtime: false},
      {:httpoison, "~> 1.7"},
      {:jason, "~> 1.2"}
    ]
  end
end
