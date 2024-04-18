import Config

config :commanded_issue_556,
  event_stores: [CommandedIssue556.EventStore],
  event_store: [
    # adapter: Commanded.EventStore.Adapters.EventStore,
    adapter: Commanded.EventStore.Adapters.InMemory,
    event_store: CommandedIssue556.EventStore,
    serializer: Commanded.Serialization.JsonSerializer
  ]

config :logger,
  level: :info
