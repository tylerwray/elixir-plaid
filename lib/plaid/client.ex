defmodule Plaid.Client do
  @moduledoc false
  use HTTPoison.Base

  defmodule MissingStructMappingError do
    defexception [:message]
  end

  # Maps API response JSON paths to their structs
  @structs %{
    "accounts" => Plaid.Accounts.Account,
    "ach" => Plaid.Auth.Numbers.ACH,
    "addresses" => Plaid.Identity.Address,
    "aprs" => Plaid.Liabilities.Credit.APR,
    "bacs" => Plaid.Auth.Numbers.BACS,
    "balances" => Plaid.Accounts.Account.Balances,
    "categories" => Plaid.Categories.Category,
    "cause" => Plaid.AssetReport.Warning.Cause,
    "credit" => Plaid.Liabilities.Credit,
    "data" => Plaid.Identity.AddressData,
    "eft" => Plaid.Auth.Numbers.EFT,
    "emails" => Plaid.Identity.Email,
    "error" => Plaid.Error,
    "historical_balances" => Plaid.Accounts.Account.HistoricalBalances,
    "holdings" => Plaid.Investments.Holding,
    "interest_rate" => Plaid.Liabilities.Mortgage.InterestRate,
    "international" => Plaid.Auth.Numbers.International,
    "investment_transactions" => Plaid.Investments.Transaction,
    "item" => Plaid.Item,
    "items" => Plaid.AssetReport.Report.Item,
    "liabilities" => Plaid.Liabilities,
    "loan_status" => Plaid.Liabilities.Student.LoanStatus,
    "location" => Plaid.Transactions.Transaction.Location,
    "mortgage" => Plaid.Liabilities.Mortgage,
    "numbers" => Plaid.Auth.Numbers,
    "owners" => Plaid.Identity,
    "payment_meta" => Plaid.Transactions.Transaction.PaymentMeta,
    "phone_numbers" => Plaid.Identity.PhoneNumber,
    "property_address" => Plaid.Address,
    "pslf_status" => Plaid.Liabilities.Student.PSLFStatus,
    "repayment_plan" => Plaid.Liabilities.Student.RepaymentPlan,
    "report" => Plaid.AssetReport.Report,
    "securities" => Plaid.Investments.Security,
    "servicer_address" => Plaid.Address,
    "student" => Plaid.Liabilities.Student,
    "transactions" => Plaid.Transactions.Transaction,
    "user" => Plaid.AssetReport.User,
    "warnings" => Plaid.AssetReport.Warning
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

  def handle_response({:ok, %{body: body, status_code: status_code}}, struct_module)
      when status_code in 200..299 do
    res =
      body
      |> Jason.decode!()
      |> structify(struct_module)

    {:ok, res}
  end

  def handle_response({:ok, %{body: body}}, _struct_module) do
    error =
      body
      |> Jason.decode!()
      |> structify(Plaid.Error)

    {:error, error}
  end

  def handle_response(res, _), do: res

  @spec structify(map(), module()) :: module()
  defp structify(generic_map, nil) when is_map(generic_map) do
    raise MissingStructMappingError,
      message: """
      Could not structify map.
      Add an internal struct mapping inside Plaid.Client to fix this error.

      Map: #{inspect(generic_map)}
      """
  end

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
