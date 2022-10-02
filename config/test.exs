import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :aglog_robot, AglogRobotWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "6hjGKFAptp/KM8wn40JnAzMQuT4s6pTU46xEh6g7jsJ6qryj+u0iNZ7nO0uMyOph",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
