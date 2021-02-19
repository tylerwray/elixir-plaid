# Plaid for Elixir

Elixir bindings for the [Plaid API](https://plaid.com/docs/api).

Documentation on [HexDocs](https://hexdocs.pm/elixir_plaid).

### Installation

Add `elixir_plaid` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:elixir_plaid, "~> 0.1.0"}
  ]
end
```

### Pillars

1. Fantastic documentation

> Provide the right documentation for developers to find what they need.

2. Full API coverage

> Do our best to keep pairity with the production Plaid API.

3. Always return structs

> Structs are a form of documentation, they make it easier for developers to work with responses. Always return them.

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
| [Payment Initiation (UK and Europe)](https://plaid.com/docs/api/products/#payment-initiation-uk-and-europe) | 🗺      |
| [Bank Transfers (beta)](https://plaid.com/docs/api/products/#bank-transfers-beta)                           | 🗺      |
| [Deposit Switch (beta)](https://plaid.com/docs/api/products/#deposit-switch-beta)                           | 🗺      |
| [Item](https://plaid.com/docs/api/items/)                                                                   | 🗺      |
| [Institution](https://plaid.com/docs/api/institutions/)                                                     | 🗺      |
| [Account](https://plaid.com/docs/api/accounts/)                                                             | ✅     |
| [Token](https://plaid.com/docs/api/tokens/)                                                                 | 🗺      |
| [Processor](https://plaid.com/docs/api/processors/)                                                         | 🗺      |
| [Sandbox](https://plaid.com/docs/api/sandbox/)                                                              | 🗺      |
| [Employer](https://plaid.com/docs/api/employers/)                                                           | 🗺      |
| [Webhooks](https://plaid.com/docs/api/webhooks/)                                                            | 🗺      |

### Usage

> TODO: Write popular example instructions

### Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tylerwray/elixir_plaid. See [contributing guidelines](CONTRIBUTING.md) also.

### License

The package is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

[version-changelog]: https://plaid.com/docs/api/versioning/
[api-version-2020-09-14]: https://plaid.com/docs/api/versioning/#2020-09-14
