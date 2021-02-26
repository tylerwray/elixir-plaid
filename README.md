# Plaid for Elixir

[![CI](https://github.com/tylerwray/elixir-plaid/actions/workflows/elixir.yml/badge.svg)](https://github.com/tylerwray/elixir-plaid/actions/workflows/elixir.yml)

Elixir bindings for the [Plaid API](https://plaid.com/docs/api).

Full Documentation on [HexDocs](https://hexdocs.pm/elixir_plaid).

### Core Principles

1. Provide Fantastic documentation.
2. Full API coverage.
3. Always return structs.

### Installation

Add `elixir_plaid` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:elixir_plaid, "~> 0.1.0"}
  ]
end
```

### Example Usage

<!-- TODO: ADD hexdocs link to Plaid.config type -->

Each function takes a [`Plaid.config`](http://hexdocslinkhere.com) keyword list as it's trailing argument.
Authenticated requests require a `client_id` and `secert` at minimum for authenication with the plaid API.

You can also pass an `env` option as either `:production`, `:development`, or `:sandbox` (default).

```elixir
# get auth data
Plaid.Auth.get("access-prod-123xxx", client_id: "123", secret: "abc")

# get item details
Plaid.Item.get("access-prod-123xxx", client_id: "123", secret: "abc", env: :production)

# refresh transactions
Plaid.Transactions.refresh("access-prod-123xxx", client_id: "123", secret: "abc", env: :development)

# get categories is unauthenticated
Plaid.Categories.get(env: :production)
```

> The choice to avoid using application configuration is due to the [anti-pattern documented by elixir](https://hexdocs.pm/elixir/master/library-guidelines.html#avoid-application-configuration)
> of libraries using application configuration. Passing "configuration" to each function avoids the library touching any
> global state. As well as making function calls objectively more "functional".

> Likely you will need to pass keys dynamically anyway for development/production, overwriting the need for global application config.
> Therefor using patterns like those outlined in [this blog post](http://blog.plataformatec.com.br/2015/10/mocks-and-explicit-contracts/) and
> using a test mocking library like [Mox](https://hexdocs.pm/mox/Mox.html) help aid in making code more clear.

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
| [Transactions](https://plaid.com/docs/api/products/#transactions)                                           | ✅     |
| [Auth](https://plaid.com/docs/api/products/#auth)                                                           | ✅     |
| [Balance](https://plaid.com/docs/api/products/#balance)                                                     | ✅     |
| [Identity](https://plaid.com/docs/api/products/#identity)                                                   | ✅     |
| [Asset Report](https://plaid.com/docs/api/products/#assets)                                                 | ✅     |
| [Investments](https://plaid.com/docs/api/products/#investments)                                             | ✅     |
| [Liabilities](https://plaid.com/docs/api/products/#liabilities)                                             | ✅     |
| [Payment Initiation (UK and Europe)](https://plaid.com/docs/api/products/#payment-initiation-uk-and-europe) | ✅     |
| [Bank Transfers (beta)](https://plaid.com/docs/api/products/#bank-transfers-beta)                           | 🗺      |
| [Deposit Switch (beta)](https://plaid.com/docs/api/products/#deposit-switch-beta)                           | 🗺      |
| [Item](https://plaid.com/docs/api/items/)                                                                   | ✅     |
| [Institution](https://plaid.com/docs/api/institutions/)                                                     | ✅     |
| [Account](https://plaid.com/docs/api/accounts/)                                                             | ✅     |
| [Token](https://plaid.com/docs/api/tokens/)                                                                 | 🗺      |
| [Processor](https://plaid.com/docs/api/processors/)                                                         | 🗺      |
| [Sandbox](https://plaid.com/docs/api/sandbox/)                                                              | 🗺      |
| [Employer](https://plaid.com/docs/api/employers/)                                                           | 🗺      |
| [Webhooks](https://plaid.com/docs/api/webhooks/)                                                            | 🗺      |

### Contributing

Bug reports and pull requests are welcome on [GitHub](https://github.com/tylerwray/elixir_plaid).
See [contributing guidelines](CONTRIBUTING.md) for more details.

### License

The package is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

[version-changelog]: https://plaid.com/docs/api/versioning/
[api-version-2020-09-14]: https://plaid.com/docs/api/versioning/#2020-09-14
