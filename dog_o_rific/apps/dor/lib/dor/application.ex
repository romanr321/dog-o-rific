defmodule Dor.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {Dor.Breeds, []},
      {Dor.Favorites, []}
      # Starts a worker by calling: Dor.Worker.start_link(arg)
      # {Dor.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Dor.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
