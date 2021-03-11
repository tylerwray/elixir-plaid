defmodule Plaid.AssetReport do
  @moduledoc """
  [Plaid Asset Reports API](https://plaid.com/docs/api/products/#assets) calls and schema.
  """

  alias Plaid.Castable
  alias Plaid.AssetReport.User

  defmodule AsyncResponse do
    @moduledoc """
    Plaid Asset Report schema used when generating asset reports.

    Async because it only returns a token, the actual asset-report needs to
    be fetched after the proper webhook is received. [See docs.](https://plaid.com/docs/api/products/#asset_reportcreate)
    """

    @behaviour Castable

    @type t :: %__MODULE__{
            asset_report_token: String.t(),
            asset_report_id: String.t(),
            request_id: String.t()
          }

    defstruct [
      :asset_report_token,
      :asset_report_id,
      :request_id
    ]

    @impl true
    def cast(generic_map) do
      %__MODULE__{
        asset_report_token: generic_map["asset_report_token"],
        asset_report_id: generic_map["asset_report_id"],
        request_id: generic_map["request_id"]
      }
    end
  end

  @doc """
  Create an Asset Report.

  Does a `POST /asset_report/create` call to initiate the process of
  creating an asset report.

  Params:
  * `access_tokens` - List of tokens coresponding to the items that will be included in the report.
  * `days_requested` - The days of history to include in the asset report.

  Options:
  * `client_report_id` - Client-generated identifier, which can be used by lenders to track loan applications.
  * `webhook` - URL Plaid will use to send webhooks for when the asset report is ready.
  * `user` - Information about the user to be appended to the asset report. See `Plaid.AssetReport.User` for available fields.

  ## Examples

      create(["access-sandbox-123xxx"], 3, client_id: "123", secret: "abc")
      {:ok, %AsyncResponse{}}

  """
  @spec create([String.t()], non_neg_integer(), options, Plaid.config()) ::
          {:ok, AsyncResponse.t()} | {:error, Plaid.Error.t()}
        when options: %{
               optional(:client_report_id) => String.t(),
               optional(:webhook) => String.t(),
               optional(:user) => User.t()
             }
  def create(access_tokens, days_requested, options \\ %{}, config) do
    options_payload = Map.take(options, [:client_report_id, :webhook, :user])

    payload =
      %{}
      |> Map.put(:access_tokens, access_tokens)
      |> Map.put(:days_requested, days_requested)
      |> Map.put(:options, options_payload)

    Plaid.Client.call("/asset_report/create", payload, AsyncResponse, config)
  end

  defmodule GetResponse do
    @moduledoc """
    [Plaid API /asset_report/get response schema](https://plaid.com/docs/api/products/#asset_reportget)
    """

    @behaviour Castable

    alias Plaid.AssetReport.{Report, Warning}

    @type t :: %__MODULE__{
            report: Report.t(),
            warnings: [Warning.t()],
            request_id: String.t()
          }

    defstruct [
      :report,
      :warnings,
      :request_id
    ]

    @impl true
    def cast(generic_map) do
      %__MODULE__{
        report: Castable.cast(Report, generic_map["report"]),
        warnings: Castable.cast_list(Warning, generic_map["warnings"]),
        request_id: generic_map["request_id"]
      }
    end
  end

  @doc """
  Get an asset report.

  Does a `POST /asset_report/get` call to fetch an asset report.

  Params:
  * `asset_report_token` - The asset report token from the `create_report` response.

  Options: 
  * `include_insights` - Whether we should retrieve the report as an "Assets + Insights" report.

  ## Examples

      get("asset-prod-123xxx", client_id: "123", secret: "abc")
      {:ok, %GetResponse{}}

  """
  @spec get(String.t(), options, Plaid.config()) ::
          {:ok, GetResponse.t()} | {:error, Plaid.Error.t()}
        when options: %{optional(:include_insights) => boolean()}
  def get(asset_report_token, options \\ %{}, config) do
    payload =
      options
      |> Map.take([:include_insights])
      |> Map.put(:asset_report_token, asset_report_token)

    Plaid.Client.call("/asset_report/get", payload, GetResponse, config)
  end

  @doc """
  Get an asset report as a PDF.

  Does a `POST /asset_report/pdf/get` call to fetch an asset report as a PDF.

  Params:
  * `asset_report_token` - The asset report token from the `create_report` response.

  ## Examples

      get_pdf("asset-prod-123xxx", client_id: "123", secret: "abc")
      {:ok, <<0, 1, 2, 3>>}

  """
  @spec get_pdf(String.t(), Plaid.config()) :: {:ok, bitstring()} | {:error, Plaid.Error.t()}
  def get_pdf(asset_report_token, config) do
    Plaid.Client.call(
      "/asset_report/pdf/get",
      %{asset_report_token: asset_report_token},
      :raw,
      config
    )
  end

  @doc """
  Create a new, refreshed Asset Report.

  Does a `POST /asset_report/refresh` call to initiate the process of
  creating a new asset report with refreshed data, based off of a previous one.

  Params:
  * `asset_report_token` - The token for the asset report you want to refresh.

  Options:
  * `client_report_id` - Client-generated identifier, which can be used by lenders to track loan applications.
  * `days_requested` - The days of history to include in the asset report.
  * `webhook` - URL Plaid will use to send webhooks for when the asset report is ready.
  * `user` - Information about the user to be appended to the asset report. See `Plaid.AssetReport.User` for available fields.

  Each option above acts as an "override" of the original values passed to `create/4`.
  Meaning when not specified, values from the original `create/4` request will be used.

  ## Examples

      refresh("assets-sandbox-123xxx", client_id: "123", secret: "abc")
      {:ok, %AsyncResponse{}}

  """
  @spec refresh(String.t(), options, Plaid.config()) ::
          {:ok, AsyncResponse.t()} | {:error, Plaid.Error.t()}
        when options: %{
               optional(:client_report_id) => String.t(),
               optional(:days_requested) => non_neg_integer(),
               optional(:webhook) => String.t(),
               optional(:user) => User.t()
             }
  def refresh(asset_report_token, options \\ %{}, config) do
    options_payload = Map.take(options, [:client_report_id, :webhook, :user])

    payload =
      %{}
      |> Plaid.Util.maybe_put(:days_requested, options)
      |> Map.put(:asset_report_token, asset_report_token)
      |> Map.put(:options, options_payload)

    Plaid.Client.call("/asset_report/refresh", payload, AsyncResponse, config)
  end

  @doc """
  Create a new, filtered Asset Report.

  Does a `POST /asset_report/filter` call to initiate the process of
  creating a new asset report with filtered accounts, based off of a previous one.

  Params:
  * `asset_report_token` - The token for the asset report you want to refresh.
  * `account_ids_to_exclude` - The accounts to exclude from the original Asset Report.

  ## Examples

      filter("assets-sandbox-123xxx", ["123xxx"], client_id: "123", secret: "abc")
      {:ok, %AsyncResponse{}}

  """
  @spec filter(String.t(), [String.t()], Plaid.config()) ::
          {:ok, AsyncResponse.t()} | {:error, Plaid.Error.t()}
  def filter(asset_report_token, account_ids_to_exclude, config) do
    Plaid.Client.call(
      "/asset_report/filter",
      %{
        asset_report_token: asset_report_token,
        account_ids_to_exclude: account_ids_to_exclude
      },
      AsyncResponse,
      config
    )
  end

  defmodule RemoveResponse do
    @moduledoc """
    [Plaid /asset_report/remove response schema.](https://plaid.com/docs/api/products/#asset_reportremove)
    """

    @behaviour Castable

    @type t :: %__MODULE__{
            removed: boolean(),
            request_id: String.t()
          }

    defstruct [
      :removed,
      :request_id
    ]

    @impl true
    def cast(generic_map) do
      %__MODULE__{
        removed: generic_map["removed"],
        request_id: generic_map["request_id"]
      }
    end
  end

  @doc """
  Remove an Asset Report.

  Does a `POST /asset_report/remove` call to remove an asset report and
  invalidate its `asset_report_token`.

  Params:
  * `asset_report_token` - The token for the asset report you want to remove.

  ## Examples

      remove("assets-sandbox-123xxx", client_id: "123", secret: "abc")
      {:ok, %RemoveResponse{}}

  """
  @spec remove(String.t(), Plaid.config()) ::
          {:ok, RemoveResponse.t()} | {:error, Plaid.Error.t()}
  def remove(asset_report_token, config) do
    Plaid.Client.call(
      "/asset_report/remove",
      %{asset_report_token: asset_report_token},
      RemoveResponse,
      config
    )
  end

  defmodule CreateAuditCopyResponse do
    @moduledoc """
    [Plaid /asset_report/audit_copy/create response schema](https://plaid.com/docs/api/products/#asset_reportaudit_copycreate)
    """

    @behaviour Castable

    @type t :: %__MODULE__{
            audit_copy_token: String.t(),
            request_id: String.t()
          }

    defstruct [
      :audit_copy_token,
      :request_id
    ]

    @impl true
    def cast(generic_map) do
      %__MODULE__{
        audit_copy_token: generic_map["audit_copy_token"],
        request_id: generic_map["request_id"]
      }
    end
  end

  @doc """
  Create an audit copy token.

  Does a `POST /asset_report/audit_copy/create` call to create an audit copy token
  which can be sent to participating auditors.

  Params:
  * `asset_report_token` - The token for which you want to create an audit copy.
  * `auditor_id` - The auditor_id of the third party with whom you would like to share the Asset Report.

  ## Examples

      create_audit_copy("assets-sandbox-123xxx", "fannie_mae", client_id: "123", secret: "abc")
      {:ok, %CreateAuditCopyResponse{}}

  """
  @spec create_audit_copy(String.t(), String.t(), Plaid.config()) ::
          {:ok, CreateAuditCopyResponse.t()} | {:error, Plaid.Error.t()}
  def create_audit_copy(asset_report_token, auditor_id, config) do
    Plaid.Client.call(
      "/asset_report/audit_copy/create",
      %{asset_report_token: asset_report_token, auditor_id: auditor_id},
      CreateAuditCopyResponse,
      config
    )
  end

  defmodule RemoveAuditCopyResponse do
    @moduledoc """
    [Plaid /asset_report/audit_copy/remove response schema.](https://plaid.com/docs/api/products/#asset_reportaudit_copyremove)
    """

    @behaviour Castable

    @type t :: %__MODULE__{
            removed: boolean(),
            request_id: String.t()
          }

    defstruct [
      :removed,
      :request_id
    ]

    @impl true
    def cast(generic_map) do
      %__MODULE__{
        removed: generic_map["removed"],
        request_id: generic_map["request_id"]
      }
    end
  end

  @doc """
  Remove an Asset Report Audit Copy.

  Does a `POST /asset_report/audit_copy/remove` call to remove an audit copy and
  invalidate its `audit_copy_token`.

  Params:
  * `audit_copy_token` - The token for the asset report audit copy you want to remove.

  ## Examples

      remove_audit_copy("a-sandbox-123xxx", client_id: "123", secret: "abc")
      {:ok, %RemoveAuditCopyResponse{}}

  """
  @spec remove_audit_copy(String.t(), Plaid.config()) ::
          {:ok, RemoveAuditCopyResponse.t()} | {:error, Plaid.Error.t()}
  def remove_audit_copy(audit_copy_token, config) do
    Plaid.Client.call(
      "/asset_report/audit_copy/remove",
      %{audit_copy_token: audit_copy_token},
      RemoveAuditCopyResponse,
      config
    )
  end
end
