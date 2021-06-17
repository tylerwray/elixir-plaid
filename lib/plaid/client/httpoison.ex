defmodule Plaid.Client.HTTPoison do
  @moduledoc """
  Implements the Plaid.Client behaviour, which calls for a `post/3` function.
  """

  @behaviour Plaid.Client

  require Logger

  @impl true
  def post(url, payload, headers) do
    HTTPoison.post(url, payload, headers)
  end
end
