# Simple Server

Minimal Plug based API implementation in Elixir without Phoenix with telemetry

Based on article by [Kamil Lelonek](https://blog.lelonek.me/minimal-elixir-http2-server-64188d0c1f3a), ([repo](https://github.com/KamilLelonek/elixir-http-json-api))

## Running Locally

* Clone repo
* Run `mix run --no-halt` inside cloned directory.

## Running on Heroku

With Heroku CLI installed:

* create new app: `heroku create <your-app-name>` - this will add a new remote called `heroku` on git configuration
* add Elixir buildpack: `heroku buildpacks:set https://github.com/HashNuke/heroku-buildpack-elixir.git`
* edit `elixir_buildpack.config` with erlang and elixir versions (currently, erlang 22, elixir 1.9.2)
* create a heroku's `Procfile` with the content: `web: mix run --no-halt`
* deploy: `git push heroku master`
