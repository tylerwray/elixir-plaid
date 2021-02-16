defmodule Plaid.Liabilities.Mortgage do
  @moduledoc """
  [Plaid Liabilities Mortage Schema.](https://plaid.com/docs/api/products/#liabilities-get-response-mortgage)
  """

  @type t :: %__MODULE__{
          account_id: String.t() | nil,
          account_number: String.t(),
          current_late_fee: number() | nil,
          escrow_balance: number() | nil,
          has_pmi: boolean() | nil,
          has_prepayment_penalty: boolean() | nil,
          interest_rate: Plaid.Liabilities.Mortgage.InterestRate.t(),
          last_payment_amount: number() | nil,
          last_payment_date: String.t() | nil,
          loan_type_description: String.t() | nil,
          loan_term: String.t() | nil,
          maturity_date: String.t() | nil,
          next_monthly_payment: number() | nil,
          next_payment_due_date: String.t() | nil,
          origination_date: String.t() | nil,
          origination_principal_amount: number() | nil,
          past_due_amount: number() | nil,
          property_address: Plaid.Address.t(),
          ytd_interest_paid: number() | nil,
          ytd_principal_paid: number() | nil
        }

  defstruct [
    :account_id,
    :account_number,
    :current_late_fee,
    :escrow_balance,
    :has_pmi,
    :has_prepayment_penalty,
    :interest_rate,
    :last_payment_amount,
    :last_payment_date,
    :loan_type_description,
    :loan_term,
    :maturity_date,
    :next_monthly_payment,
    :next_payment_due_date,
    :origination_date,
    :origination_principal_amount,
    :past_due_amount,
    :property_address,
    :ytd_interest_paid,
    :ytd_principal_paid
  ]
end
