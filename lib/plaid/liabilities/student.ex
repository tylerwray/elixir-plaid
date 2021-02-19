defmodule Plaid.Liabilities.Student do
  @moduledoc """
  [Plaid Liabilities Student Schema.](https://plaid.com/docs/api/products/#liabilities-get-response-student)
  """

  @behaviour Plaid.Castable

  alias Plaid.Address
  alias Plaid.Castable
  alias Plaid.Liabilities.Student.{LoanStatus, PSLFStatus, RepaymentPlan}

  @type t :: %__MODULE__{
          account_id: String.t() | nil,
          account_number: String.t() | nil,
          disbursement_dates: [String.t()] | nil,
          expected_payoff_date: String.t() | nil,
          guarantor: String.t() | nil,
          interest_rate_percentage: number(),
          is_overdue: boolean() | nil,
          last_payment_amount: number() | nil,
          last_payment_date: String.t() | nil,
          last_statement_balance: number() | nil,
          last_statement_issue_date: String.t() | nil,
          loan_name: String.t() | nil,
          loan_status: LoanStatus.t(),
          minimum_payment_amount: number() | nil,
          next_payment_due_date: String.t() | nil,
          origination_date: String.t() | nil,
          origination_principal_amount: number() | nil,
          outstanding_interest_amount: number() | nil,
          payment_reference_number: String.t() | nil,
          pslf_status: PSLFStatus.t(),
          repayment_plan: RepaymentPlan.t(),
          sequence_number: String.t() | nil,
          servicer_address: Address.t(),
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

  @impl true
  def cast(generic_map) do
    %__MODULE__{
      account_id: generic_map["account_id"],
      account_number: generic_map["account_number"],
      disbursement_dates: generic_map["disbursement_dates"],
      expected_payoff_date: generic_map["expected_payoff_date"],
      guarantor: generic_map["guarantor"],
      interest_rate_percentage: generic_map["interest_rate_percentage"],
      is_overdue: generic_map["is_overdue"],
      last_payment_amount: generic_map["last_payment_amount"],
      last_payment_date: generic_map["last_payment_date"],
      last_statement_balance: generic_map["last_statement_balance"],
      last_statement_issue_date: generic_map["last_statement_issue_date"],
      loan_name: generic_map["loan_name"],
      loan_status: Castable.cast(LoanStatus, generic_map["loan_status"]),
      minimum_payment_amount: generic_map["minimum_payment_amount"],
      next_payment_due_date: generic_map["next_payment_due_date"],
      origination_date: generic_map["origination_date"],
      origination_principal_amount: generic_map["origination_principal_amount"],
      outstanding_interest_amount: generic_map["outstanding_interest_amount"],
      payment_reference_number: generic_map["payment_reference_number"],
      pslf_status: Castable.cast(PSLFStatus, generic_map["pslf_status"]),
      repayment_plan: Castable.cast(RepaymentPlan, generic_map["repayment_plan"]),
      sequence_number: generic_map["sequence_number"],
      servicer_address: Castable.cast(Address, generic_map["servicer_address"]),
      ytd_interest_paid: generic_map["ytd_interest_paid"],
      ytd_principal_paid: generic_map["ytd_principal_paid"]
    }
  end
end
