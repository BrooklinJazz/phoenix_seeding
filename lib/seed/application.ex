defmodule Seed.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Seed.Repo,
      # Start the Telemetry supervisor
      SeedWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Seed.PubSub},
      # Start the Endpoint (http/https)
      SeedWeb.Endpoint
      # Start a worker by calling: Seed.Worker.start_link(arg)
      # {Seed.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Seed.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    SeedWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
