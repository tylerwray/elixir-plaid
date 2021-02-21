defmodule Plaid.PaymentInitiation do
  @moduledoc """
  [Plaid Payment Initiation API](https://plaid.com/docs/api/products/#payment-initiation-uk-and-europe) calls and schema.
  """

  alias Plaid.PaymentInitiation.{
    Amount,
    BACS,
    CreatePaymentResponse,
    CreateRecipientResponse,
    GetRecipientResponse,
    GetPaymentResponse,
    ListRecipientsResponse,
    RecipientAddress,
    Schedule
  }

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
          {:ok, CreateRecipientResponse.t()} | {:error, Plaid.Error.t()}
        when options: %{
               optional(:iban) => String.t(),
               optional(:bacs) => BACS.t(),
               optional(:address) => RecipientAddress.t()
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
      CreateRecipientResponse,
      config
    )
  end

  @doc """
  Get a recipient for payment initiation.

  Does a `POST /payment_initiation/recipient/get` call to
  get details about a payment recipient.

  ## Params

  * `recipient_id` - The ID of the recipient.

  ## Examples

      PaymentInitiation.get_recipient("recipient-id-sandbox-123xxx", client_id: "123", secret: "abc")
      {:ok, %PaymentInitiation.GetRecipientResponse{}}

  """
  @spec get_recipient(recipient_id :: String.t(), Plaid.config()) ::
          {:ok, CreateRecipientResponse.t()} | {:error, Plaid.Error.t()}
  def get_recipient(recipient_id, config) do
    Plaid.Client.call(
      "/payment_initiation/recipient/get",
      %{recipient_id: recipient_id},
      GetRecipientResponse,
      config
    )
  end

  @doc """
  List the payment recipients that you have previously created.

  Does a `POST /payment_initiation/recipient/list` call to
  list all recipients you have previously created.


  ## Examples

      PaymentInitiation.list_recipients(client_id: "123", secret: "abc")
      {:ok, %PaymentInitiation.ListRecipientResponse{}}

  """
  @spec list_recipients(Plaid.config()) ::
          {:ok, ListRecipientResponse.t()} | {:error, Plaid.Error.t()}
  def list_recipients(config) do
    Plaid.Client.call(
      "/payment_initiation/recipient/list",
      ListRecipientsResponse,
      config
    )
  end

  @doc """
  Create a payment for a recipient.

  Does a `POST /payment_initiation/payment/create` call which creates
  a one-time or standing (recurring) payment for a recipient.

  ## Params

  * `recipient_id` - The ID of the recipient the payment is for.
  * `reference` - A reference for the payment.
  * `amount` - A payment amount.

  ## Options

  * `:schedule` - The schedule that the payment will be executed on.

  ## Examples

      PaymentInitiation.create_payment(
        "recipient-id-prod-123xxx",
        "Purchase Order  123",
        %PaymentInitiation.Amount{currency: "GBP", value: 200},
        %{
          schedule: %Plaid.PaymentInitiation.Schedule{
            interval: "WEEKLY",
            interval_execution_day: 2,
            start_date: "2021-01-01",
            end_date: "2021-01-31"
          }
        },
        client_id: "123",
        secret: "abc"
      )
      {:ok, %PaymentInitiation.CreateRecipientResponse{}}

  """
  @spec create_payment(
          recipient_id :: String.t(),
          reference :: String.t(),
          amount :: Amount.t(),
          options,
          Plaid.config()
        ) :: {:ok, CreatePaymentResponse.t()} | {:error, Plaid.Error.t()}
        when options: %{optional(:schedule) => Schedule.t()}
  def create_payment(recipient_id, reference, amount, options \\ %{}, config) do
    payload =
      %{}
      |> Map.put(:recipient_id, recipient_id)
      |> Map.put(:reference, reference)
      |> Map.put(:amount, amount)
      |> Plaid.Util.maybe_put(:schedule, options)

    Plaid.Client.call(
      "/payment_initiation/payment/create",
      payload,
      CreatePaymentResponse,
      config
    )
  end

  @doc """
  Get payment details.

  Does a `POST /payment_initiation/payment/create` call to get
  details about a payment.

  ## Params

  * `payment_id` - The payment_id returned from /payment_initiation/payment/create.

  ## Examples

      PaymentInitiation.get_payment(
        "payment-id-prod-123xxx",
        client_id: "123",
        secret: "abc"
      )
      {:ok, %PaymentInitiation.GetPaymentResponse{}}

  """
  @spec get_payment(payment_id :: String.t(), Plaid.config()) ::
          {:ok, GetPaymentResponse.t()} | {:error, Plaid.Error.t()}
  def get_payment(payment_id, config) do
    Plaid.Client.call(
      "/payment_initiation/payment/get",
      %{payment_id: payment_id},
      GetPaymentResponse,
      config
    )
  end
end
