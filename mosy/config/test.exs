use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :mosy, MosyWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :debug

# Configure your database
config :mosy, Mosy.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "mosy_test",
  hostname: "db",
  pool: Ecto.Adapters.SQL.Sandbox
