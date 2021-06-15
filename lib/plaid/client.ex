defmodule Plaid.Client do
  @moduledoc """
  Uses [HTTPoison](https://github.com/edgurgel/httpoison) by default, but can be swapped out for any HTTP client you'd like. To use HTTPoison, just make sure it's included in your deps and you're good to go:

    `{:httpoison, "~> 1.7"}`

  To use a different HTTP client, create a new module like `MyApp.PlaidClient` which implements
  `post/3` and uses the `@behaviour Plaid.Client` behaviour.

  For an example, see the Plaid.Client.HTTPoison module.

  The success response of those functions must return a `:body` key, with a JSON value, and a `:status_code` key with an integer HTTP status.

  Then, you'll need to add the following to `config.exs`:

    `config :elixir_plaid, client: MyApp.PlaidClient`
  """

  require Logger

  alias Plaid.Castable

  @type url :: String.t()
  @type payload :: String.t()
  @type headers :: [{String.t(), String.t()}]

  @doc "Callback to initialize api client"
  @callback init() :: :ok

  @doc "Callback to POST the data"
  @callback post(url, payload, headers) ::
              {:ok, %{:body => String.t(), :status_code => integer(), optional(any) => any}}
              | {:error, any()}

  @optional_callbacks init: 0

  def init do
    client = http_client()

    if Code.ensure_loaded?(client) and function_exported?(client, :init, 0) do
      :ok = client.init()
    end

    :ok
  end

  @doc """
  Make a Plaid API call.

  Takes in everything needed to complete the request and
  return a well formed struct of the response.

  ## Examples

      call(
        "/categories/get",
        %{},
        Plaid.Categories.GetResponse,
        client_id: "123",
        secret: "abc"
      )
      {:ok, %Plaid.Categories.GetResponse{}}

  """
  @spec call(String.t(), map(), module(), Plaid.config()) ::
          {:ok, any()} | {:error, Plaid.Error.t()}
  def call(endpoint, payload \\ %{}, castable_module, config) do
    url = build_url(config, endpoint)

    payload =
      payload
      |> add_auth(config)
      |> Jason.encode!()

    url
    |> http_client().post(payload, headers())
    |> handle_response(castable_module)
  end

  @spec build_url(Plaid.config(), String.t()) :: String.t()
  defp build_url(config, endpoint) do
    test_api_host = Keyword.get(config, :test_api_host)

    if is_binary(test_api_host) do
      test_api_host <> endpoint
    else
      env = Keyword.get(config, :env, :sandbox)
      "https://#{env}.plaid.com#{endpoint}"
    end
  end

  @spec add_auth(map(), Plaid.config()) :: map()
  defp add_auth(payload, config) do
    auth =
      config
      |> Map.new()
      |> Map.take([:client_id, :secret])

    Map.merge(payload, auth)
  end

  @spec handle_response(
          {:ok, %{:body => String.t(), :status_code => integer(), optional(any) => any}}
          | {:error, any()},
          module() | :raw
        ) :: {:ok, String.t() | %{optional(any) => any}} | {:error, Plaid.Error.t()}
  def handle_response({:ok, %{body: body, status_code: status_code}}, :raw)
      when status_code in 200..299 do
    {:ok, body}
  end

  def handle_response({:ok, %{body: json_body, status_code: status_code}}, castable_module)
      when status_code in 200..299 do
    case Jason.decode(json_body) do
      {:ok, generic_map} -> {:ok, Castable.cast(castable_module, generic_map)}
      _ -> {:error, Castable.cast(Plaid.Error, %{})}
    end
  end

  def handle_response({:ok, %{body: json_body}}, _castable_module) do
    case Jason.decode(json_body) do
      {:ok, generic_map} -> {:error, Castable.cast(Plaid.Error, generic_map)}
      _ -> {:error, Castable.cast(Plaid.Error, %{})}
    end
  end

  def handle_response(res, _) do
    Logger.warn([
      "[#{__MODULE__}] un-",
      " un-handled response.",
      " #{inspect(res)}",
      " Create an issue or pull request with the above response",
      " at https://github.com/tylerwray/elixir-plaid."
    ])

    {:error, Castable.cast(Plaid.Error, %{})}
  end

  defp headers, do: [{"Content-Type", "application/json"}]
  defp http_client, do: Application.fetch_env!(:elixir_plaid, :client)
end
