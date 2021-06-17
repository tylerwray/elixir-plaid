defmodule Plaid.Client do
  @moduledoc """
  Make API calls to plaid and convert the responses from JSON -> well typed elixir structs

  To use a different HTTP client, create a new module like `MyApp.PlaidClient` which implements
  `post/3` and implements the `@behaviour Plaid.Client` behaviour. The success response of those functions must return a `:body` key with a JSON string value
  and a `:status_code` key with an integer HTTP status. For an example, see the `Plaid.Client.HTTPoison` module.

  > For network errors where you don't get a body or status code, you may return an error tuple
  > with any error value, but the error value is not currently utilized.
  """

  require Logger

  alias Plaid.Castable

  @doc """
  Callback to POST the data to the Plaid API.

  Will be called with the full URL, payload, and headers. Simply take these values
  execute the HTTP request.

  > `headers` passed in will be a list of two item tuples where the first item is the header key
  > and the second is the value. e.g. `[{"content-type", "application/json"}]`

  ## Examples

      iex> post("https://production.plaid.com/categories/get", ~s<{"thing": "stuff"}>, [{"content-type", "application/json"}])
      {:ok, %{body: ~s<{"foo": "bar"}>, status_code: 200}}

  """
  @callback post(url :: String.t(), payload :: String.t(), headers :: [{String.t(), String.t()}]) ::
              {:ok, %{body: String.t(), status_code: integer()}} | {:error, any()}

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

    headers = [{"content-type", "application/json"}]

    http_client = Keyword.get(config, :http_client, Plaid.Client.HTTPoison)

    IO.inspect(http_client)

    case http_client.post(url, payload, headers) do
      {:ok, %{body: body, status_code: status_code}} when status_code in 200..299 ->
        {:ok, cast_body(body, castable_module)}

      {:ok, %{body: body}} ->
        {:error, cast_body(body, Plaid.Error)}

      {:error, _error} ->
        {:error, Castable.cast(Plaid.Error, %{})}
    end
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

  @spec cast_body(String.t(), module() | :raw) :: String.t() | %{optional(any) => any}
  defp cast_body(body, :raw) do
    body
  end

  defp cast_body(json_body, castable_module) do
    case Jason.decode(json_body) do
      {:ok, generic_map} -> Castable.cast(castable_module, generic_map)
      _ -> Castable.cast(Plaid.Error, %{})
    end
  end
end
