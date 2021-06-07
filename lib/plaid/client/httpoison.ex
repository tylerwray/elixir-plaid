defmodule Plaid.Client.HTTPoison do
  @moduledoc """
  Implements the Plaid.Client behaviour, which calls for a `post/3` function.

  Also implements the optional `init/0` function, to ensure that HTTPoison is
  listed as a dependency and loaded if a custom module isn't being used.
  """

  @behaviour Plaid.Client

  require Logger

  @impl true
  def init do
    unless Code.ensure_loaded?(HTTPoison) do
      Logger.error """
      Could not find http client dependency.

      Please add HTTPoison to your dependencies:

          {:httpoison, "~> 0.7"}

      Or set your own client:

          config :httpoison, :client, MyApp.CustomClient

      See Plaid.Client docs for more info: https://hexdocs.pm/httpoison/Plaid.Client.html
      """

      raise "missing httpoison dependency"
    end

    {:ok, _} = Application.ensure_all_started(:httpoison)
    :ok
  end

  @impl true
  def post(url, payload, headers) do
    HTTPoison.post(url, payload, headers)
  end
end
