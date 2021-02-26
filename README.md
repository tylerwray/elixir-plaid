# Plaid Elixir Library

[![CI](https://github.com/tylerwray/elixir-plaid/actions/workflows/elixir.yml/badge.svg)](https://github.com/tylerwray/elixir-plaid/actions/workflows/elixir.yml)

> Simply Beautiful Elixir bindings for the [Plaid API](https://plaid.com/docs/api).

Full Documentation on [HexDocs](https://hexdocs.pm/elixir_plaid).

### Core Principles

1. Fantastic documentation
2. Full plaid API coverage
3. Always return structs

### Example Usage

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

[`Plaid.Accounts`](https://hexdocs.pm/elixir_plaid/doc/Plaid.Accounts.html#content)

[`Plaid.AssetReport`](https://hexdocs.pm/elixir_plaid/doc/Plaid.AssetReport.html#content)

[`Plaid.Auth`](https://hexdocs.pm/elixir_plaid/doc/Plaid.Auth.html#content)

[`Plaid.Balance`](https://hexdocs.pm/elixir_plaid/doc/Plaid.Balance.html#content)

[`Plaid.Identity`](https://hexdocs.pm/elixir_plaid/doc/Plaid.Identity.html#content)

[`Plaid.Institution`](https://hexdocs.pm/elixir_plaid/doc/Plaid.Institution.html#content)

[`Plaid.Investments`](https://hexdocs.pm/elixir_plaid/doc/Plaid.Investments.html#content)

[`Plaid.Item`](https://hexdocs.pm/elixir_plaid/doc/Plaid.Item.html#content)

[`Plaid.Liabilities`](https://hexdocs.pm/elixir_plaid/doc/Plaid.Liabilities.html#content)

[`Plaid.PaymentInitiation`](https://hexdocs.pm/elixir_plaid/doc/Plaid.PaymentInitiation.html#content)

[`Plaid.Transactions`](https://hexdocs.pm/elixir_plaid/doc/Plaid.Transactions.html#content)


Full Documentation on [HexDocs](https://hexdocs.pm/elixir_plaid).

<!-- TODO: ADD hexdocs link to Plaid.config type -->

Each function takes a [`Plaid.config`](http://hexdocslinkhere.com) keyword list as it's trailing argument.
Authenticated requests require a `client_id` and `secert` at minimum for authentication with the plaid API.

You can also pass an `env` option as either `:production`, `:development`, or `:sandbox` (default).

> The choice to avoid using application configuration is due to the [anti-pattern documented by elixir](https://hexdocs.pm/elixir/master/library-guidelines.html#avoid-application-configuration)
> of libraries using application configuration. Passing "configuration" to each function avoids the library touching any
> global state. As well as making function calls objectively more "functional".

> Likely you will need to pass keys dynamically anyway for development/production, overwriting the need for global application config.
> Therefor using patterns like those outlined in [this blog post](http://blog.plataformatec.com.br/2015/10/mocks-and-explicit-contracts/) and
> using a test mocking library like [Mox](https://hexdocs.pm/mox/Mox.html) help aid in making code more clear.

### Installation

Add `elixir_plaid` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:elixir_plaid, "~> 0.1.0"}
  ]
end
```

### Versioning

Each major version of `elixir_plaid` targets a specific version of the Plaid API:

| API version                                         | package version |
| --------------------------------------------------- | --------------- |
| [`2020-09-14`][api-version-2020-09-14] (**latest**) | `0.x.x`         |

For information about what has changed tyler API versions, head to the [version changelog][version-changelog].

### API Coverage

✅ - Full Coverage

🏗 - In Progress

🗺 - On the Roadmap

| API                                                                                                         | Status |
| ----------------------------------------------------------------------------------------------------------- | ------ |
| [Account](https://plaid.com/docs/api/accounts/)                                                             | ✅     |
| [Asset Report](https://plaid.com/docs/api/products/#assets)                                                 | ✅     |
| [Auth](https://plaid.com/docs/api/products/#auth)                                                           | ✅     |
| [Balance](https://plaid.com/docs/api/products/#balance)                                                     | ✅     |
| [Bank Transfers (beta)](https://plaid.com/docs/api/products/#bank-transfers-beta)                           | 🗺      |
| [Deposit Switch (beta)](https://plaid.com/docs/api/products/#deposit-switch-beta)                           | 🗺      |
| [Employer](https://plaid.com/docs/api/employers/)                                                           | 🗺      |
| [Identity](https://plaid.com/docs/api/products/#identity)                                                   | ✅     |
| [Institution](https://plaid.com/docs/api/institutions/)                                                     | ✅     |
| [Investments](https://plaid.com/docs/api/products/#investments)                                             | ✅     |
| [Item](https://plaid.com/docs/api/items/)                                                                   | ✅     |
| [Liabilities](https://plaid.com/docs/api/products/#liabilities)                                             | ✅     |
| [Payment Initiation (UK and Europe)](https://plaid.com/docs/api/products/#payment-initiation-uk-and-europe) | ✅     |
| [Processor](https://plaid.com/docs/api/processors/)                                                         | 🗺      |
| [Sandbox](https://plaid.com/docs/api/sandbox/)                                                              | 🗺      |
| [Token](https://plaid.com/docs/api/tokens/)                                                                 | 🗺      |
| [Transactions](https://plaid.com/docs/api/products/#transactions)                                           | ✅     |
| [Webhooks](https://plaid.com/docs/api/webhooks/)                                                            | 🗺      |

### Contributing

Bug reports and pull requests are welcome on [GitHub](https://github.com/tylerwray/elixir_plaid).
See [contributing guidelines](CONTRIBUTING.md) for more details.

### License

The package is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

[version-changelog]: https://plaid.com/docs/api/versioning/
[api-version-2020-09-14]: https://plaid.com/docs/api/versioning/#2020-09-14
