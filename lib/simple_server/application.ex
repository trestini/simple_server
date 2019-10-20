defmodule SimpleServer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  import Logger

  def start(_type, _args) do

    Monitor.setup_custom_metrics()

    info "Starting supervised application #{Application.get_env(:simple_server, :name)}"

    children = [
      SimpleServer.Router,
      Monitor.setup_prometheus_metrics()
    ]

    opts = [strategy: :one_for_one, name: SimpleServer.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
