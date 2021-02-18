defmodule Plaid.Client do
  @moduledoc false
  use HTTPoison.Base

  def process_request_headers(headers) do
    [{"Content-Type", "application/json"}] ++ headers
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
          {:ok, map()} | {:error, Plaid.Error.t()}
  def call(endpoint, payload, castable_struct, config) do
    url = build_url(config, endpoint)

    payload =
      payload
      |> add_auth(config)
      |> Jason.encode!()

    :post
    |> request(url, payload)
    |> handle_response(castable_struct)
  end

  @spec build_url(Plaid.config(), String.t()) :: String.t()
  defp build_url(config, endpoint) do
    test_api_host = Keyword.get(config, :test_api_host)

    if is_binary(test_api_host) do
      test_api_host <> endpoint
    else
      env = Keyword.get(config, :env, Application.fetch_env!(:elixir_plaid, :env))
      "https://#{env}.plaid.com#{endpoint}"
    end
  end

  @spec add_auth(String.t(), Plaid.config()) :: map()
  defp add_auth(payload, config) do
    auth =
      config
      |> Map.new()
      |> Map.take([:client_id, :secret])

    Map.merge(payload, auth)
  end

  def handle_response({:ok, %{body: body, status_code: status_code}}, :raw)
      when status_code in 200..299 do
    {:ok, body}
  end

  def handle_response({:ok, %{body: body, status_code: status_code}}, castable_struct)
      when status_code in 200..299 do
    res =
      body
      |> Jason.decode!()
      |> castable_struct.cast()

    {:ok, res}
  end

  def handle_response({:ok, %{body: body}}, _castable_struct) do
    error =
      body
      |> Jason.decode!()
      |> Plaid.Error.cast()

    {:error, error}
  end

  def handle_response(res, _), do: res
end
