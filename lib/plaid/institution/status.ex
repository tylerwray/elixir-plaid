defmodule Plaid.Institution.Status do
  @moduledoc """
  [Plaid institution status schema.](https://plaid.com/docs/api/institutions/#institutions-get-response-status)
  """

  @behaviour Plaid.Castable

  alias Plaid.Castable

  defmodule Breakdown do
    @moduledoc """
    [Plaid institution status breakdown schema.](https://plaid.com/docs/api/institutions/#institutions-get-response-breakdown)
    """

    @behaviour Castable

    @type t :: %__MODULE__{
            success: number(),
            error_plaid: number(),
            error_institution: number(),
            refresh_interval: String.t() | nil
          }

    defstruct [
      :success,
      :error_plaid,
      :error_institution,
      :refresh_interval
    ]

    @impl true
    def cast(generic_map) do
      %__MODULE__{
        success: generic_map["success"],
        error_plaid: generic_map["error_plaid"],
        error_institution: generic_map["error_institution"],
        refresh_interval: generic_map["refresh_interval"]
      }
    end
  end

  defmodule Auth do
    @moduledoc """
    [Plaid institution auth status schema.](https://plaid.com/docs/api/institutions/#institutions-get-response-auth)
    """

    @behaviour Castable

    @type t :: %__MODULE__{
            status: String.t(),
            last_status_change: String.t(),
            breakdown: Breakdown.t()
          }

    defstruct [
      :status,
      :last_status_change,
      :breakdown
    ]

    @impl true
    def cast(generic_map) do
      %__MODULE__{
        status: generic_map["status"],
        last_status_change: generic_map["last_status_change"],
        breakdown: Castable.cast(Breakdown, generic_map["breakdown"])
      }
    end
  end

  defmodule Balance do
    @moduledoc """
    [Plaid institution balance status schema.](https://plaid.com/docs/api/institutions/#institutions-get-response-balance)
    """

    @behaviour Castable

    @type t :: %__MODULE__{
            status: String.t(),
            last_status_change: String.t(),
            breakdown: Breakdown.t()
          }

    defstruct [
      :status,
      :last_status_change,
      :breakdown
    ]

    @impl true
    def cast(generic_map) do
      %__MODULE__{
        status: generic_map["status"],
        last_status_change: generic_map["last_status_change"],
        breakdown: Castable.cast(Breakdown, generic_map["breakdown"])
      }
    end
  end

  defmodule HealthIncidentUpdate do
    @moduledoc """
    [Plaid institution status health incident update schema.](https://plaid.com/docs/api/institutions/#institutions-get-response-incident-updates)
    """

    @behaviour Castable

    @type t :: %__MODULE__{
            description: String.t(),
            status: String.t(),
            updated_date: String.t()
          }

    defstruct [
      :description,
      :status,
      :updated_date
    ]

    @impl true
    def cast(generic_map) do
      %__MODULE__{
        description: generic_map["description"],
        status: generic_map["status"],
        updated_date: generic_map["updated_date"]
      }
    end
  end

  defmodule HealthIncident do
    @moduledoc """
    [Plaid institution status health incident schema.](https://plaid.com/docs/api/institutions/#institutions-get-response-health-incidents)
    """

    @behaviour Castable

    @type t :: %__MODULE__{
            start_date: String.t() | nil,
            end_date: String.t() | nil,
            title: String.t(),
            incident_updates: [HealthIncidentUpdate.t()]
          }

    defstruct [
      :start_date,
      :end_date,
      :title,
      :incident_updates
    ]

    @impl true
    def cast(generic_map) do
      %__MODULE__{
        start_date: generic_map["start_date"],
        end_date: generic_map["end_date"],
        title: generic_map["title"],
        incident_updates:
          Castable.cast_list(HealthIncidentUpdate, generic_map["incident_updates"])
      }
    end
  end

  defmodule Identity do
    @moduledoc """
    [Plaid institution identity status schema.](https://plaid.com/docs/api/institutions/#institutions-get-response-identity)
    """

    @behaviour Castable

    @type t :: %__MODULE__{
            status: String.t(),
            last_status_change: String.t(),
            breakdown: Breakdown.t()
          }

    defstruct [
      :status,
      :last_status_change,
      :breakdown
    ]

    @impl true
    def cast(generic_map) do
      %__MODULE__{
        status: generic_map["status"],
        last_status_change: generic_map["last_status_change"],
        breakdown: Castable.cast(Breakdown, generic_map["breakdown"])
      }
    end
  end

  defmodule InvestmentsUpdates do
    @moduledoc """
    [Plaid institution investments updates status schema.](https://plaid.com/docs/api/institutions/#institutions-get-response-investments-updates)
    """

    @behaviour Castable

    @type t :: %__MODULE__{
            status: String.t(),
            last_status_change: String.t(),
            breakdown: Breakdown.t()
          }

    defstruct [
      :status,
      :last_status_change,
      :breakdown
    ]

    @impl true
    def cast(generic_map) do
      %__MODULE__{
        status: generic_map["status"],
        last_status_change: generic_map["last_status_change"],
        breakdown: Castable.cast(Breakdown, generic_map["breakdown"])
      }
    end
  end

  defmodule ItemLogins do
    @moduledoc """
    [Plaid institution item logins status schema.](https://plaid.com/docs/api/institutions/#institutions-get-response-item-logins)
    """

    @behaviour Castable

    @type t :: %__MODULE__{
            status: String.t(),
            last_status_change: String.t(),
            breakdown: Breakdown.t()
          }

    defstruct [
      :status,
      :last_status_change,
      :breakdown
    ]

    @impl true
    def cast(generic_map) do
      %__MODULE__{
        status: generic_map["status"],
        last_status_change: generic_map["last_status_change"],
        breakdown: Castable.cast(Breakdown, generic_map["breakdown"])
      }
    end
  end

  defmodule TransactionsUpdates do
    @moduledoc """
    [Plaid institution transactions updates status schema.](https://plaid.com/docs/api/institutions/#institutions-get-response-transactions-updates)
    """

    @behaviour Castable

    @type t :: %__MODULE__{
            status: String.t(),
            last_status_change: String.t(),
            breakdown: Breakdown.t()
          }

    defstruct [
      :status,
      :last_status_change,
      :breakdown
    ]

    @impl true
    def cast(generic_map) do
      %__MODULE__{
        status: generic_map["status"],
        last_status_change: generic_map["last_status_change"],
        breakdown: Castable.cast(Breakdown, generic_map["breakdown"])
      }
    end
  end

  @type t :: %__MODULE__{
          auth: Auth.t(),
          balance: Balance.t(),
          health_incidents: [HealthIncident.t()] | nil,
          identity: Identity.t(),
          investments_updates: InvestmentsUpdates.t(),
          item_logins: ItemLogins.t(),
          transactions_updates: TransactionsUpdates.t()
        }

  defstruct [
    :auth,
    :balance,
    :health_incidents,
    :identity,
    :investments_updates,
    :item_logins,
    :transactions_updates
  ]

  @impl true
  def cast(generic_map) do
    %__MODULE__{
      auth: Castable.cast(Auth, generic_map["auth"]),
      balance: Castable.cast(Balance, generic_map["balance"]),
      health_incidents: Castable.cast_list(HealthIncident, generic_map["health_incidents"]),
      identity: Castable.cast(Identity, generic_map["identity"]),
      investments_updates: Castable.cast(InvestmentsUpdates, generic_map["investments_updates"]),
      item_logins: Castable.cast(ItemLogins, generic_map["item_logins"]),
      transactions_updates:
        Castable.cast(TransactionsUpdates, generic_map["transactions_updates"])
    }
  end
end
