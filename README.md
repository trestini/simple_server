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

## Running on docker

* to run locally using docker compose: `docker-compose up` on root directory
* to run locally without docker compose, first build the container with `docker build -t simple_server:latest -f .docker/build.dockerfile .`, and then run with `docker run -p <local port>:4001 simple_server`