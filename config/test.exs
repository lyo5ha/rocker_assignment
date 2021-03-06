use Mix.Config

# Configure your database
config :rocker_assignment, RockerAssignment.Repo,
  username: "rocker_user",
  password: "rocker",
  database: "rocker_assignment_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :rocker_assignment, RockerAssignmentWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
