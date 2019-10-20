defmodule Monitor do
  require Logger
  import Telemetry.Metrics

  def setup_prometheus_metrics do
    # https://hexdocs.pm/telemetry_metrics_prometheus/overview.html (localhost:9568) - no TLS support
    metrics = [
      distribution("simple_server.plug.stop.duration", buckets: [100000,250000,500000,1000000,2000000]),
      last_value("vm.memory.total", unit: :megabyte),
      last_value("simple_server.app.checked_at.time", unit: :millisecond)
    ]

    {TelemetryMetricsPrometheus, [metrics: metrics, validations: [require_seconds: false]]}
  end

  def setup_custom_metrics do
    events = [
      [:simple_server, :app, :boot]
    ]
    :telemetry.attach_many("simple_server_app_boot", events, &handle_event/4, nil)
  end

  def handle_event([:simple_server, :app, :checked_at], measurements, _metadata, _config) do
    Logger.info "Last healthcheck at #{measurements.time}"
  end

end
