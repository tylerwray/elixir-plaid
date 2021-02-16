defmodule Plaid.Liabilities.Credit do
  @moduledoc """
  [Plaid Liabilities Credit Schema.](https://plaid.com/docs/api/products/#liabilities-get-response-credit)
  """

  @type t :: %__MODULE__{
          account_id: String.t() | nil,
          aprs: list(Plaid.Liabilities.Credit.APR.t()),
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
end
