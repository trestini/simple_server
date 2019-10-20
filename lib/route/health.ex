defmodule Route.Health do
  use Plug.Router

  plug :match
  plug Plug.Telemetry, event_prefix: [:simple_server, :plug]
  plug :dispatch

  get "/check" do
    :telemetry.execute([:simple_server, :app, :checked_at], %{time: :os.system_time(:milli_seconds)}, %{})
    conn
      |> put_resp_content_type("application/json")
      |> send_resp(200, Poison.encode!(%{"response" => NaiveDateTime.utc_now}))
  end

  post "/set" do
    {:ok, _, %Plug.Conn{body_params: body}} = conn |> Plug.Conn.read_body
    resp = %{"received" => body, "ok" => true}
    send_resp(conn, 200, Poison.encode!(resp))
  end

  match _ do
    send_resp(conn, 404, "Not Found")
  end

end
