defmodule AglogRobot.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      AglogRobotWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: AglogRobot.PubSub},
      # Start the Endpoint (http/https)
      AglogRobotWeb.Endpoint
      # Start a worker by calling: AglogRobot.Worker.start_link(arg)
      # {AglogRobot.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AglogRobot.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AglogRobotWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
