import Config

config :commanded_issue_556,
  event_stores: [CommandedIssue556.EventStore]

config :commanded_issue_556, CommandedIssue556.EventStore,
  serializer: Commanded.Serialization.JsonSerializer,
  hostname: "localhost",
  username: "postgres",
  password: "postgres",
  database: "commanded_issue_556",
  port: 5555

config :logger,
  level: :error
