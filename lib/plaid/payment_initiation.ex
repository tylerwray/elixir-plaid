defmodule Plaid.PaymentInitiation do
  @moduledoc """
  [Plaid Payment Initiation API](https://plaid.com/docs/api/products/#payment-initiation-uk-and-europe) calls and schema.
  """

  alias Plaid.PaymentInitiation.{
    BACS,
    CreateRecipientResponse,
    GetRecipientResponse,
    ListRecipientsResponse,
    RecipientAddress
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
end
