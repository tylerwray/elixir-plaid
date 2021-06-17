defmodule Plaid do
  @moduledoc """
  Shared types used in the library.
  """

  @typedoc "Supported environments in the Plaid API."
  @type env :: :production | :development | :sandbox

  @typedoc """
  Configuration that can be passed to each authenticated request.

    * `:client_id` - The client_id Plaid uses for authentication.
    * `:secret` - The secret Plaid uses for authentication.
    * `:env` - A supported [Plaid environment](https://plaid.com/docs/api/#api-host).
    * `:http_client` - Any module that implements the `Plaid.Client` behaviour.
    * `:test_api_host` - A way to override the URL for requests. Useful for E2E or integration testing.

  > `client_id` and `secret` are required.
  """
  @type config :: [
          client_id: String.t(),
          secret: String.t(),
          env: env(),
          http_client: module(),
          test_api_host: String.t()
        ]

  @typedoc """
  Configuration that can be passed to any un-authenticated request.

    * `:env` - A supported [Plaid environment](https://plaid.com/docs/api/#api-host).
    * `:http_client` - Any module that implements the `Plaid.Client` behaviour.
    * `:test_api_host` - A way to override the URL for requests. Useful for E2E or integration testing.
  """
  @type noauth_config :: [
          test_api_host: String.t(),
          http_client: module(),
          env: env()
        ]
end
