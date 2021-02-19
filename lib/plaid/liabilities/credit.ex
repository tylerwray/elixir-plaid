defmodule Plaid.Liabilities.Credit do
  @moduledoc """
  [Plaid Liabilities Credit Schema.](https://plaid.com/docs/api/products/#liabilities-get-response-credit)
  """

  @behaviour Plaid.Castable

  alias Plaid.Castable
  alias Plaid.Liabilities.Credit.APR

  @type t :: %__MODULE__{
          account_id: String.t() | nil,
          aprs: [APR.t()],
          is_overdue: boolean() | nil,
          last_payment_amount: number(),
          last_payment_date: String.t(),
          last_statement_balance: number(),
          last_statement_issue_date: String.t(),
          minimum_payment_amount: number(),
          next_payment_due_date: String.t()
        }

  defstruct [
    :account_id,
    :aprs,
    :is_overdue,
    :last_payment_amount,
    :last_payment_date,
    :last_statement_balance,
    :last_statement_issue_date,
    :minimum_payment_amount,
    :next_payment_due_date
  ]

  @impl true
  def cast(generic_map) do
    %__MODULE__{
      account_id: generic_map["account_id"],
      aprs: Castable.cast_list(APR, generic_map["aprs"]),
      is_overdue: generic_map["is_overdue"],
      last_payment_amount: generic_map["last_payment_amount"],
      last_payment_date: generic_map["last_payment_date"],
      last_statement_balance: generic_map["last_statement_balance"],
      last_statement_issue_date: generic_map["last_statement_issue_date"],
      minimum_payment_amount: generic_map["minimum_payment_amount"],
      next_payment_due_date: generic_map["next_payment_due_date"]
    }
  end
end
