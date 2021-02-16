defmodule Plaid.Liabilities.Student do
  @moduledoc """
  [Plaid Liabilities Student Schema.](https://plaid.com/docs/api/products/#liabilities-get-response-student)
  """

  @type t :: %__MODULE__{
          account_id: String.t() | nil,
          account_number: String.t() | nil,
          disbursement_dates: list(String.t()) | nil,
          expected_payoff_date: String.t() | nil,
          guarantor: String.t() | nil,
          interest_rate_percentage: number(),
          is_overdue: boolean() | nil,
          last_payment_amount: number() | nil,
          last_payment_date: String.t() | nil,
          last_statement_balance: number() | nil,
          last_statement_issue_date: String.t() | nil,
          loan_name: String.t() | nil,
          loan_status: Plaid.Liabilities.Student.LoanStatus.t(),
          minimum_payment_amount: number() | nil,
          next_payment_due_date: String.t() | nil,
          origination_date: String.t() | nil,
          origination_principal_amount: number() | nil,
          outstanding_interest_amount: number() | nil,
          payment_reference_number: String.t() | nil,
          pslf_status: Plaid.Liabilities.Student.PSLFStatus.t(),
          repayment_plan: Plaid.Liabilities.Student.RepaymentPlan.t(),
          sequence_number: String.t() | nil,
          servicer_address: Plaid.Address.t(),
          ytd_interest_paid: number() | nil,
          ytd_principal_paid: number() | nil
        }

  defstruct [
    :account_id,
    :account_number,
    :disbursement_dates,
    :expected_payoff_date,
    :guarantor,
    :interest_rate_percentage,
    :is_overdue,
    :last_payment_amount,
    :last_payment_date,
    :last_statement_balance,
    :last_statement_issue_date,
    :loan_name,
    :loan_status,
    :minimum_payment_amount,
    :next_payment_due_date,
    :origination_date,
    :origination_principal_amount,
    :outstanding_interest_amount,
    :payment_reference_number,
    :pslf_status,
    :repayment_plan,
    :sequence_number,
    :servicer_address,
    :ytd_interest_paid,
    :ytd_principal_paid
  ]
end
