use Mix.Config

config :simple_server,
  SimpleServer.Router,
  port: "PORT" |> System.get_env |> String.to_integer
