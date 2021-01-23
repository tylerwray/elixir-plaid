defmodule Plaid.Client do
  @moduledoc false
  use HTTPoison.Base

  # Maps API response JSON paths to their structs
  @structs %{
    "accounts" => Plaid.Accounts.Account,
    "balances" => Plaid.Accounts.Account.Balances,
    "categories" => Plaid.Categories.Category,
    "error" => Plaid.Error,
    "item" => Plaid.Item,
    "location" => Plaid.Transactions.Transaction.Location,
    "payment_meta" => Plaid.Transactions.Transaction.PaymentMeta,
    "transactions" => Plaid.Transactions.Transaction
  }

  def process_request_headers(headers) do
    [{"Content-Type", "application/json"}] ++ headers
  end

  @spec call(String.t(), map(), module(), Plaid.config()) ::
          {:ok, map()} | {:error, Plaid.Error.t()}
  def call(endpoint, payload, struct_module, config) do
    url = build_url(config, endpoint)

    payload =
      payload
      |> add_auth(config)
      |> Jason.encode!()

    :post
    |> request(url, payload)
    |> handle_response(struct_module)
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
    client_id = Keyword.fetch!(config, :client_id)
    secret = Keyword.fetch!(config, :secret)

    payload
    |> Map.put(:client_id, client_id)
    |> Map.put(:secret, secret)
  end

  def handle_response({:ok, %{body: body}}, struct_module) do
    res =
      body
      |> Jason.decode!()
      |> structify(struct_module)

    {:ok, res}
  end

  def handle_response(res, _), do: res

  @spec structify(map(), module()) :: module()
  defp structify(generic_map, module) when is_map(generic_map) do
    # Convert a generic API response from Plaid to a supported struct.
    # Pass the API response along with it's struct to convert to.
    atomized_map = Map.new(generic_map, &cast_key_and_value/1)
    struct(module, atomized_map)
  end

  defp structify(value, _) do
    value
  end

  @spec cast_key_and_value({String.t(), any()}) :: {atom(), any()}
  defp cast_key_and_value({key, value}) when is_map(value) do
    {String.to_existing_atom(key), structify(value, @structs[key])}
  end

  defp cast_key_and_value({key, value}) when is_list(value) do
    {String.to_existing_atom(key), Enum.map(value, &structify(&1, @structs[key]))}
  end

  defp cast_key_and_value({key, value}) do
    {String.to_existing_atom(key), value}
  end
end
