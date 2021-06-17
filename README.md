# Plaid Elixir Library

[![build](https://github.com/tylerwray/elixir-plaid/actions/workflows/elixir.yml/badge.svg)](https://github.com/tylerwray/elixir-plaid/actions/workflows/elixir.yml) [![Hex Version](https://img.shields.io/hexpm/v/elixir_plaid.svg)](https://hex.pm/packages/elixir_plaid) [![Hex Docs](https://img.shields.io/badge/hex.pm-docs-green.svg?style=flat)](https://hexdocs.pm/elixir_plaid) ![Hex.pm](https://img.shields.io/hexpm/dt/elixir_plaid) [![MIT License](https://img.shields.io/hexpm/l/elixir_plaid)](https://opensource.org/licenses/MIT)

> Simply Beautiful Elixir library for the [Plaid API](https://plaid.com/docs/api).

## Motivation & Principles

1. Provide FANTASTIC documentation
2. Full plaid API coverage
3. Use the plaid API versioning plan
4. Return well-defined structs, always

## Example Usage

```elixir
# get auth data
Plaid.Auth.get("access-prod-123xxx", client_id: "123", secret: "abc")

# get item details
Plaid.Item.get("access-prod-123xxx", client_id: "123", secret: "abc", env: :production)

# refresh transactions
Plaid.Transactions.refresh("access-prod-123xxx", client_id: "123", secret: "abc", env: :development)

# get categories
Plaid.Categories.get(env: :production)
```

## API

- [`Plaid.Accounts`](https://hexdocs.pm/elixir_plaid/Plaid.Accounts.html#content)
- [`Plaid.AssetReport`](https://hexdocs.pm/elixir_plaid/Plaid.AssetReport.html#content)
- [`Plaid.Auth`](https://hexdocs.pm/elixir_plaid/Plaid.Auth.html#content)
- [`Plaid.Categories`](https://hexdocs.pm/elixir_plaid/Plaid.Categories.html#content)
- [`Plaid.Employer`](https://hexdocs.pm/elixir_plaid/Plaid.Employer.html#content)
- [`Plaid.Identity`](https://hexdocs.pm/elixir_plaid/Plaid.Identity.html#content)
- [`Plaid.Institution`](https://hexdocs.pm/elixir_plaid/Plaid.Institution.html#content)
- [`Plaid.Investments`](https://hexdocs.pm/elixir_plaid/Plaid.Investments.html#content)
- [`Plaid.Item`](https://hexdocs.pm/elixir_plaid/Plaid.Item.html#content)
- [`Plaid.Liabilities`](https://hexdocs.pm/elixir_plaid/Plaid.Liabilities.html#content)
- [`Plaid.LinkToken`](https://hexdocs.pm/elixir_plaid/Plaid.LinkToken.html#content)
- [`Plaid.PaymentInitiation`](https://hexdocs.pm/elixir_plaid/Plaid.PaymentInitiation.html#content)
- [`Plaid.Processor`](https://hexdocs.pm/elixir_plaid/Plaid.Processor.html#content)
- [`Plaid.Sandbox`](https://hexdocs.pm/elixir_plaid/Plaid.Sandbox.html#content)
- [`Plaid.Transactions`](https://hexdocs.pm/elixir_plaid/Plaid.Transactions.html#content)
- [`Plaid.Webhooks`](https://hexdocs.pm/elixir_plaid/Plaid.Webhooks.html#content)

Full Documentation on [HexDocs](https://hexdocs.pm/elixir_plaid).

## Configuration

Each function takes a [`Plaid.config`](https://hexdocs.pm/elixir_plaid/Plaid.html#t:config/0) keyword list as it's trailing argument.
Authenticated requests require a `client_id` and `secert` at minimum for authentication with the plaid API.

| Key              | Value                                                                                           |
| ---------------- | ----------------------------------------------------------------------------------------------- |
| `:client_id`     | Your plaid client id. (required for authenticated requests)                                     |
| `:secret`        | Your plaid secret. (required for authenticated requests)                                        |
| `:env`           | Either `:production`, `:development`, or `:sandbox`. (defaults to `:sandbox`)                   |
| `:http_client`   | Any module that implements the `Plaid.Client` behaviour. (defaults to `Plaid.Client.HTTPoison`) |
| `:test_api_host` | Any base URL e.g. `http://localhost:2100/`.                                                     |

> The choice to avoid using application configuration is due to the [anti-pattern documented by elixir](https://hexdocs.pm/elixir/master/library-guidelines.html#avoid-application-configuration)
> of libraries using application configuration. Passing configuration to each function avoids the library touching any
> global state, as well as making function calls objectively more "functional".

> Likely you will need to pass keys dynamically anyway for development/production, overwriting the need for global application config.
> Therefore using patterns like those outlined in [this blog post](https://blog.plataformatec.com.br/2015/10/mocks-and-explicit-contracts/) and
> using a test mocking library like [Mox](https://hexdocs.pm/mox/Mox.html) help aid in making code more clear.

## Installation

Add `elixir_plaid` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:elixir_plaid, "~> 1.0.0"}

    # optional, but recommended http client
    {:httpoison, "~> 1.7"}
  ]
end
```

## Versioning

Each major version of `elixir_plaid` targets a specific version of the Plaid API:

| API version                                         | package version |
| --------------------------------------------------- | --------------- |
| [`2020-09-14`][api-version-2020-09-14] (**latest**) | `1.x.x`         |

For information about what has changed between API versions, head to the [version changelog][version-changelog].

## API Coverage

✅ - Full Coverage

🏗 - In Progress

🗺 - On the Roadmap

| API                                                                                                         | Status |
| ----------------------------------------------------------------------------------------------------------- | ------ |
| [Account](https://plaid.com/docs/api/accounts/)                                                             | ✅     |
| [Assets](https://plaid.com/docs/api/products/#assets)                                                       | ✅     |
| [Auth](https://plaid.com/docs/api/products/#auth)                                                           | ✅     |
| [Balance](https://plaid.com/docs/api/products/#balance)                                                     | ✅     |
| [Bank Transfers (beta)](https://plaid.com/docs/api/products/#bank-transfers-beta)                           | 🗺      |
| [Deposit Switch (beta)](https://plaid.com/docs/api/products/#deposit-switch-beta)                           | 🗺      |
| [Employer](https://plaid.com/docs/api/employers/)                                                           | 🏗      |
| [Identity](https://plaid.com/docs/api/products/#identity)                                                   | ✅     |
| [Institution](https://plaid.com/docs/api/institutions/)                                                     | ✅     |
| [Investments](https://plaid.com/docs/api/products/#investments)                                             | ✅     |
| [Item](https://plaid.com/docs/api/items/)                                                                   | ✅     |
| [Liabilities](https://plaid.com/docs/api/products/#liabilities)                                             | ✅     |
| [Payment Initiation (UK and Europe)](https://plaid.com/docs/api/products/#payment-initiation-uk-and-europe) | ✅     |
| [Processor](https://plaid.com/docs/api/processors/)                                                         | ✅     |
| [Sandbox](https://plaid.com/docs/api/sandbox/)                                                              | 🏗      |
| [Token](https://plaid.com/docs/api/tokens/)                                                                 | ✅     |
| [Transactions](https://plaid.com/docs/api/products/#transactions)                                           | ✅     |
| [Webhooks](https://plaid.com/docs/api/webhooks/)                                                            | 🏗      |

## Contributing

Bug reports and pull requests are welcome on [GitHub](https://github.com/tylerwray/elixir_plaid).
See [contributing guidelines](CONTRIBUTING.md) for more details.

## License

The package is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

[version-changelog]: https://plaid.com/docs/api/versioning/
[api-version-2020-09-14]: https://plaid.com/docs/api/versioning/#2020-09-14
