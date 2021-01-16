# Plaid for Elixir

Elixir bindings for the [Plaid API](https://plaid.com/docs).

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

### Versioning

Each major version of `elixir_plaid` targets a specific version of the Plaid API:

| API version                                         | elixir_uuid release |
| --------------------------------------------------- | ------------------- |
| [`2020-09-14`][api-version-2020-09-14] (**latest**) | `0.x.x`             |

For information about what has changed between API versions, head to the [version changelog][version-changelog].

## Usage

> TODO: Write popular example instructions

This package wraps the Plaid API, which is fully described in the [documentation](https://plaid.com/docs/api).

The HexPM docs for the package are available [here](http://plaid.github.io/plaid-ruby/).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tylerwray/elixir_plaid. See [contributing guidelines](CONTRIBUTING.md) also.

## License

The package is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

[version-changelog]: https://plaid.com/docs/api/versioning/
[api-version-2020-09-14]: https://plaid.com/docs/api/versioning/#2020-09-14
