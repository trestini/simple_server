defmodule SimpleServer.Router do

  require Logger
  use Plug.Router

  if Mix.env == :dev do
    Logger.debug "Adding Plug.Debugger"
    use Plug.Debugger
  end

  use Plug.ErrorHandler

  plug :match

  plug Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Poison

  plug :dispatch

  forward("/health", to: Route.Health)

  match _ do
    send_resp(conn, 404, "Not Found by Plug")
  end

  defp handle_errors(conn, error) do
    Logger.error error
    send_resp(conn, conn.status, "Bad bad server... no donuts for you")
  end

  def child_spec(opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [opts]}
    }
  end

  def start_link(_opts) do
    with {:ok, [port: port] = config} <- Application.fetch_env(:simple_server, __MODULE__) do
      Logger.info("Listening at http://localhost:#{port}/")
      Plug.Adapters.Cowboy.http(__MODULE__, [], config)
    end
  end

end
