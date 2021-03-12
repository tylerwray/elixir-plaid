defmodule Plaid.PaymentInitiation do
  @moduledoc """
  [Plaid Payment Initiation API](https://plaid.com/docs/api/products/#payment-initiation-uk-and-europe) calls and schema.
  """

  alias Plaid.Castable

  alias Plaid.PaymentInitiation.{
    Address,
    Amount,
    BACS,
    Payment,
    Recipient,
    Schedule
  }

  defmodule CreateRecipientResponse do
    @moduledoc """
    [Plaid API /payment_initiation/recipient/create response schema.](https://plaid.com/docs/api/products/#payment_initiationrecipientcreate)
    """

    @behaviour Castable

    @type t :: %__MODULE__{
            recipient_id: String.t(),
            request_id: String.t()
          }

    defstruct [
      :recipient_id,
      :request_id
    ]

    @impl true
    def cast(generic_map) do
      %__MODULE__{
        recipient_id: generic_map["recipient_id"],
        request_id: generic_map["request_id"]
      }
    end
  end

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
               optional(:address) => Address.t()
             }
  def create_recipient(name, options \\ %{}, config) do
    options_payload = Map.take(options, [:iban, :bacs, :address])

    payload =
      %{}
      |> Map.put(:name, name)
      |> Map.merge(options_payload)

    Plaid.Client.call(
      "/payment_initiation/recipient/create",
      payload,
      CreateRecipientResponse,
      config
    )
  end

  defmodule GetRecipientResponse do
    @moduledoc """
    [Plaid API /payment_initiation/recipient/get response schema.](https://plaid.com/docs/api/products/#payment_initiationrecipientget)
    """

    @behaviour Castable

    @type t :: %__MODULE__{
            recipient_id: String.t(),
            name: String.t(),
            address: Address.t() | nil,
            iban: String.t() | nil,
            bacs: BACS.t() | nil,
            request_id: String.t()
          }

    defstruct [
      :recipient_id,
      :name,
      :address,
      :iban,
      :bacs,
      :request_id
    ]

    @impl true
    def cast(generic_map) do
      %__MODULE__{
        recipient_id: generic_map["recipient_id"],
        name: generic_map["name"],
        address: Castable.cast(Address, generic_map["address"]),
        iban: generic_map["iban"],
        bacs: Castable.cast(BACS, generic_map["bacs"]),
        request_id: generic_map["request_id"]
      }
    end
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

  defmodule ListRecipientsResponse do
    @moduledoc """
    [Plaid API /payment_initiation/recipient/list response schema.](https://plaid.com/docs/api/products/#payment_initiationrecipientlist)
    """

    @behaviour Castable

    @type t :: %__MODULE__{
            recipients: [Recipient.t()],
            request_id: String.t()
          }

    defstruct [
      :recipients,
      :request_id
    ]

    @impl true
    def cast(generic_map) do
      %__MODULE__{
        recipients: Castable.cast_list(Recipient, generic_map["recipients"]),
        request_id: generic_map["request_id"]
      }
    end
  end

  @doc """
  List the payment recipients that you have previously created.

  Does a `POST /payment_initiation/recipient/list` call to
  list all recipients you have previously created.


  ## Examples

      PaymentInitiation.list_recipients(client_id: "123", secret: "abc")
      {:ok, %PaymentInitiation.ListRecipientsResponse{}}

  """
  @spec list_recipients(Plaid.config()) ::
          {:ok, ListRecipientsResponse.t()} | {:error, Plaid.Error.t()}
  def list_recipients(config) do
    Plaid.Client.call(
      "/payment_initiation/recipient/list",
      ListRecipientsResponse,
      config
    )
  end

  defmodule CreatePaymentResponse do
    @moduledoc """
    [Plaid API /payment_initiation/payment/create response schema.](https://plaid.com/docs/api/products/#payment_initiationpaymentcreate)
    """

    @behaviour Castable

    @type t :: %__MODULE__{
            payment_id: String.t(),
            status: String.t(),
            request_id: String.t()
          }

    defstruct [
      :payment_id,
      :status,
      :request_id
    ]

    @impl true
    def cast(generic_map) do
      %__MODULE__{
        payment_id: generic_map["payment_id"],
        status: generic_map["status"],
        request_id: generic_map["request_id"]
      }
    end
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
          schedule: %PaymentInitiation.Schedule{
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

  defmodule GetPaymentResponse do
    @moduledoc """
    [Plaid API /payment_initiation/payment/get response schema.](https://plaid.com/docs/api/products/#payment_initiationpaymentget)
    """

    @behaviour Castable

    @type t :: %__MODULE__{
            payment_id: String.t(),
            payment_token: String.t(),
            amount: Amount.t(),
            status: String.t(),
            recipient_id: String.t(),
            reference: String.t(),
            last_status_update: String.t(),
            schedule: Schedule.t() | nil,
            adjusted_reference: String.t() | nil,
            payment_expiration_time: String.t() | nil,
            request_id: String.t()
          }

    defstruct [
      :payment_id,
      :payment_token,
      :amount,
      :status,
      :recipient_id,
      :reference,
      :last_status_update,
      :schedule,
      :adjusted_reference,
      :payment_expiration_time,
      :request_id
    ]

    @impl true
    def cast(generic_map) do
      %__MODULE__{
        payment_id: generic_map["payment_id"],
        payment_token: generic_map["payment_token"],
        amount: Castable.cast(Amount, generic_map["amount"]),
        status: generic_map["status"],
        recipient_id: generic_map["recipient_id"],
        reference: generic_map["reference"],
        last_status_update: generic_map["last_status_update"],
        schedule: Castable.cast(Schedule, generic_map["schedule"]),
        adjusted_reference: generic_map["adjust_reference"],
        payment_expiration_time: generic_map["payment_expiration_time"],
        request_id: generic_map["request_id"]
      }
    end
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

  defmodule ListPaymentsResponse do
    @moduledoc """
    [Plaid API /payment_initiation/payment/list response schema.](https://plaid.com/docs/api/products/#payment_initiationpaymentlist)
    """

    @behaviour Castable

    @type t :: %__MODULE__{
            payments: [Payment.t()],
            next_cursor: String.t(),
            request_id: String.t()
          }

    defstruct [
      :payments,
      :next_cursor,
      :request_id
    ]

    @impl true
    def cast(generic_map) do
      %__MODULE__{
        payments: Castable.cast_list(Payment, generic_map["payments"]),
        next_cursor: generic_map["next_cursor"],
        request_id: generic_map["request_id"]
      }
    end
  end

  @doc """
  List payments.

  Does a `POST /payment_initiation/payment/list` call to get
  all created payments.

  ## Options

  * `:count` - The maximum number of payments to return.
  * `:cursor` - A date string in RFC 3339 format. Only payments created before the cursor will be returned.

  ## Examples

      PaymentInitiation.list_payments(
        client_id: "123",
        secret: "abc"
      )
      {:ok, %PaymentInitiation.ListPaymentsResponse{}}

  """
  @spec list_payments(options, Plaid.config()) ::
          {:ok, ListPaymentsResponse.t()} | {:error, Plaid.Error.t()}
        when options: %{
               optional(:count) => integer(),
               optional(:cursor) => String.t()
             }
  def list_payments(options \\ %{}, config) do
    payload = Map.take(options, [:count, :cursor])

    Plaid.Client.call(
      "/payment_initiation/payment/list",
      payload,
      ListPaymentsResponse,
      config
    )
  end
end
