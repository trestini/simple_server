defmodule SimpleServer.MixProject do
  use Mix.Project

  def project do
    [
      app: :simple_server,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {SimpleServer.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:poison, "~> 4.0.1"},
      {:plug, "~> 1.8.3"},
      {:cowboy, "~> 2.7.0"},
      {:plug_cowboy, "~> 2.0"},
      {:telemetry, "~> 0.4.0"},
      {:telemetry_metrics_prometheus, "~> 0.3"},
      {:telemetry_poller, "~> 0.4"}
    ]
  end
end
