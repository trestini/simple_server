defmodule Monitor do
  require Logger

  def setup do
    events = [
      [:simple_server, :plug, :stop]
    ]
    :telemetry.attach_many("simple_server_requests", events, &handle_event/4, nil)
  end

  def handle_event([:simple_server, :plug, :stop], measurements, metadata, _config) do
    duration = System.convert_time_unit(measurements.duration, :nanosecond, :microsecond)
    Logger.info("#{metadata.conn.status} #{metadata.conn.method} #{metadata.conn.request_path} :: #{duration}µs")
  end
end
