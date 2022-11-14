FROM elixir:latest

ENV MIX_ENV=prod

RUN mkdir /app
COPY . /app
WORKDIR /app

RUN mix local.hex --force
RUN mix local.rebar --force

RUN apt-get update && apt-get install -y nodejs npm
RUN npm install -g n
RUN n 18.7.0

RUN mix deps.get --only prod
RUN mix deps.compile
RUN mix web
CMD SECRET_KEY_BASE=$(mix phx.gen.secret) mix phx.server
