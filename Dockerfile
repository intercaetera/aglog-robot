FROM elixir:latest

RUN mkdir /app
COPY . /app
WORKDIR /app

RUN mix local.hex --force
RUN mix local.rebar --force

RUN apt-get update && apt-get install -y nodejs npm
RUN npm install -g n
RUN n 18.7.0

RUN mix deps.get
RUN mix web
CMD mix phx.server
