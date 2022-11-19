defmodule SurveyliveOnline.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      SurveyliveOnline.Repo,
      # Start the Telemetry supervisor
      SurveyliveOnlineWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: SurveyliveOnline.PubSub},
      # Start the Endpoint (http/https)
      SurveyliveOnlineWeb.Endpoint,
      # Start a worker by calling: SurveyliveOnline.Worker.start_link(arg)
      # {SurveyliveOnline.Worker, arg}
      {Oban, oban_config()},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SurveyliveOnline.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SurveyliveOnlineWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp oban_config do
    Application.fetch_env!(:surveylive_online, Oban)
  end
end
