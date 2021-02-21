defmodule Plaid.PaymentInitiation do
  @moduledoc """
  [Plaid Payment Initiation API](https://plaid.com/docs/api/products/#payment-initiation-uk-and-europe) calls and schema.
  """

  @doc """
  Create a recipient for payment initiation.

  Does a `POST /payment_initiation/recipient/create` call which creates a payment
  recipient for payment initiation. 

  The endpoint is idempotent: if a request has already been made with the
  same payment details, Plaid will return the same `recipient_id`.

  ## Params

  * `name` - The name of the recipient.

  ## Options

  * `:iban` - The International Bank Account Number (IBAN) for the recipient.
  * `:bacs` - The sort code of the account.
  * `:address` - The address of the payment recipient.

  If `:bacs` data is not provided, `:iban` becomes required.

  ## Examples

      PaymentInitiation.create_recipient("Wonder Wallet", client_id: "123", secret: "abc")
      {:ok, %PaymentInitiation.CreateRecipientResponse{}}

  """
  @spec create_recipient(name :: String.t(), options, Plaid.config()) ::
          {:ok, Plaid.PaymentInitiation.CreateRecipientResponse.t()} | {:error, Plaid.Error.t()}
        when options: %{
               optional(:iban) => String.t(),
               optional(:bacs) => Plaid.PaymentInitiation.BACS.t(),
               optional(:address) => Plaid.Address.t()
             }
  def create_recipient(name, options \\ %{}, config) do
    options_payload = Map.take(options, [:iban, :bacs, :address])

    payload =
      %{}
      |> Map.put(:name, name)
      |> Map.put(:options, options_payload)

    Plaid.Client.call(
      "/payment_initiation/recipient/create",
      payload,
      Plaid.PaymentInitiation.CreateRecipientResponse,
      config
    )
  end
end
