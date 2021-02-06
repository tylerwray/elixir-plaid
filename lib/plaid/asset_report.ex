defmodule Plaid.AssetReport do
  @moduledoc """
  [Plaid Asset Reports API](https://plaid.com/docs/api/products/#assets) calls and schema.
  """

  @doc """
  Create an Asset Report.

  Does a `POST /asset_reports/create` call to initiate the process of
  creating an asset report.

  Params:
  * `access_tokens` - List of tokens coresponding to the items that will be
  included in the report.
  * `days_requested` - The days of history to include in the asset report.

  Options:
  * `client_report_id` - Client-generated identifier, which can be used
  by lenders to track loan applications.
  * `webhook` - URL Plaid will use to send webhooks for when the asset report
  is ready.
  * `user` - Information about the user to be appended to the asset report. 
  See `Plaid.AssetReport.User` for available fields.

  Returns a `Plaid.AssetReport.CreateResponse` struct with information,
  that can be used later to fetch the created asset report.

  ## Examples

      create(["access-sandbox-123xxx"], 3, client_id: "123", secret: "abc")
      {:ok, %Plaid.AssetReport.CreateResponse{}}

  """
  @spec create(list(String.t()), non_neg_integer(), options, Plaid.config()) ::
          {:ok, Plaid.AssetReport.CreateResponse.t()} | {:error, Plaid.Error.t()}
        when options: %{
               optional(:client_report_id) => String.t(),
               optional(:webhook) => String.t(),
               optional(:user) => Plaid.Assets.User.t()
             }
  def create(access_tokens, days_requested, options \\ %{}, config) do
    options_payload = Map.take(options, [:client_report_id, :webhook, :user])

    payload =
      %{}
      |> Map.put(:access_tokens, access_tokens)
      |> Map.put(:days_requested, days_requested)
      |> Map.put(:options, options_payload)

    Plaid.Client.call("/asset_report/create", payload, Plaid.AssetReport.CreateResponse, config)
  end

  @doc """
  Get an asset report.

  Does a `POST /asset_reports/get` call to fetch an asset report.

  Params:
  * `asset_report_token` - The asset report token from the `create_report` response.

  Options: 
  * `include_insights` - Whether we should retrieve the report as an "Assets + Insights" report.

  Returns a `Plaid.AssetReport.GetResponse` struct.

  ## Examples

      get("asset-prod-123xxx", client_id: "123", secret: "abc")
      {:ok, %Plaid.AssetReport.GetResponse{}}

  """
  @spec get(String.t(), options, Plaid.config()) ::
          {:ok, Plaid.AssetReport.GetResponse.t()} | {:error, Plaid.Error.t()}
        when options: %{optional(:include_insights) => boolean()}
  def get(asset_report_token, options \\ %{}, config) do
    payload =
      options
      |> Map.take([:include_insights])
      |> Map.put(:asset_report_token, asset_report_token)

    Plaid.Client.call("/asset_report/get", payload, Plaid.AssetReport.GetResponse, config)
  end
end
