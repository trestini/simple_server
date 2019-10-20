FROM elixir:1.9-alpine

### SETUP do Container
RUN mkdir /app
WORKDIR /app
COPY . .

RUN mix local.hex --force && mix deps.get

CMD ["mix", "run", "--no-halt"]