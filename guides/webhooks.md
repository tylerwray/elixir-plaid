# Webhooks example

Implementing webhook verification can be very tricky. Hopefully this library
can help make it a little less painful by strictly adhering to contract with the Plaid API so you don't have to worry about it.

> This is the path of least resistence gathered from phoenix/plug documentation. There may be other nuances that your app
> needs to account for. This guide is based on a base generated phoenix app with `mix phx.new my_app`.

To start using plaid webhooks in a standard phoenix application, you can do the following.

1. [Raw body access](#raw-body-access)
2. [Register a webhook route](#register-a-webhook-route)
3. [Setup a controller](#setup-a-controller)

## Raw body access

Plaid uses a verification token that is generated from the "raw" request body sent to your webhook endpoint. You will
need access to that same "raw" request body to verify the request using their token.

To do so, add a custom body reader so that you'll have access to the raw body in the controller.

Pulled straight from the [Plug.Parser docs](https://hexdocs.pm/plug/Plug.Parsers.html#module-custom-body-reader).

```elixir
# lib/my_app_web/endpoint.ex
defmodule CacheBodyReader do
  def read_body(conn, opts) do
    {:ok, body, conn} = Plug.Conn.read_body(conn, opts)
    conn = update_in(conn.assigns[:raw_body], &[body | &1 || []])
    {:ok, body, conn}
  end
end

plug Plug.Parsers,
  parsers: [:urlencoded, :multipart, :json],
  pass: ["*/*"],
  body_reader: {CacheBodyReader, :read_body, []},
  json_decoder: Phoenix.json_library()
```

## Register a webhook route

You need a route that your app exposes so that Plaid can make an API call to you.

```elixir
# lib/my_app_web/router.ex
scope "/webhooks", MyAppWeb do
  pipe_through :api

  post "/plaid", PlaidWebhookController, :index
end
```

## Setup a controller

Now you need to handle any requests that come to the `/webhooks/plaid` route on your app.

> Notice how we're using the raw body from `conn.assigns[:raw_body]` setup in the first step.

```elixir
# lib/my_app_web/controllers/plaid_webhook_controller.ex
defmodule MyAppWeb.PlaidWebhookController do
  use MyAppWeb, :controller

  def index(conn, _) do
    jwt =
      conn
      |> get_req_header("plaid-verification")
      |> List.first()

    raw_body = conn.assigns[:raw_body]

    config = [client_id: "123", secret: "abc"]

    case Plaid.Webhooks.verify_and_construct(jwt, raw_body, config) do
      {:ok, body} ->
        handle_webhook(body)
        json(conn, %{"status" => "ok"})

      _ ->
        conn
        |> put_status(400)
        |> json(%{"status" => "error"})
    end
  end

  defp handle_webhook(%{
         webhook_type: "TRANSACTIONS",
         webhook_code: "DEFAULT_UPDATE",
         item_id: item_id
       }) do
    # Update transactions with item_id
  end

  defp handle_webhook(%{
         webhook_type: "AUTH",
         webhook_code: "VERIFICATION_EXPIRED",
         account_id: account_id
       }) do
    # Tell user to re-verify
  end

  defp handle_webhook(_), do: :ok
end
```

---

There you have it! You are now setup to process webhooks from plaid 🎉
