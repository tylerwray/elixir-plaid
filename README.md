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

Get [Auth](https://plaid.com/docs/api/products/#auth) data:

```elixir
iex> Plaid.Auth.get("asset-prod-123xxx", client_id: "123", secret: "abc")
{:ok, %Plaid.Auth.GetResponse{
  accounts: [
    %Plaid.Account{
      name: "Plaid Checking",
      type: "depository",
      subtype: "checking",
      # ...
    }
  ],
  numbers: %Plaid.Auth.Numbers{
    ach: %Plaid.Auth.Numbers.ACH{
      account: "9900009606",
      account_id: "vzeNDwK7KQIm4yEog683uElbp9GRLEFXGK98D",
      routing: "011401533",
      wire_routing: "021000021"
    }
  }
}}
```

Get [Item](https://plaid.com/docs/api/items/#itemget) status information:

```elixir
iex> Plaid.Item.get("asset-prod-123xxx", client_id: "123", secret: "abc")
{:ok, %Plaid.Item.GetResponse{
  item: %Plaid.Item{
    institution_id: "ins_109508",
    item_id: "Ed6bjNrDLJfGvZWwnkQlfxwoNz54B5C97ejBr",
    update_type: "background",
    webhook: "https://plaid.com/example/hook",
  },
  status: %Plaid.Item.Status{
    transactions: %Plaid.Item.Status.Transactions{
      last_successful_update: "2019-02-15T15:52:39.000Z",
      last_failed_update: "2019-01-22T04:32:00.000Z"
    }
  }
}}
```

Refresh [Transactions](https://plaid.com/docs/api/products/#transactions):

```elixir
iex> Plaid.Transactions.refresh("asset-prod-123xxx", client_id: "123", secret: "abc")
{:ok, %Plaid.SimpleResponse{
  request_id: "ksl9302ksjgkea"
}}
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
