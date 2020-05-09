defmodule DorWeb.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      DorWeb.Telemetry,
      # Start the Endpoint (http/https)
      DorWeb.Endpoint
      # Start a worker by calling: DorWeb.Worker.start_link(arg)
      # {DorWeb.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DorWeb.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    DorWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
