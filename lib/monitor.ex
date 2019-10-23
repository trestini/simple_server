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
      [:health, :request, :stop]
    ]
    :telemetry.attach_many("simple_server_health_request_stop", events, &handle_event/4, nil)
  end

  def handle_event([:health, :request, :stop], measurements, metadata, _config) do
    duration = System.convert_time_unit(measurements.duration, :nanosecond, :microsecond)
    Logger.info "#{metadata.conn.status} [#{metadata.conn.method}] #{metadata.conn.request_path} :: Healthcheck request took #{duration} µs"
  end

  def handle_event([:simple_server, :app, :checked_at], measurements, _metadata, _config) do
    Logger.info "Last healthcheck at #{measurements.time}"
  end

end
