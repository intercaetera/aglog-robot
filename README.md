# AglogRobot

Generate logs from random stuff.

## Requirements

- Elixir 1.14.0 OTP 25
- Node 18.7.0

## Run dev

```
# TTY 1
iex -S mix phx.server

# TTY 2
cd frontend && npm run dev
```

## Run prod

```
mix deps.get
mix web
mix phx.server
```
