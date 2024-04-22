defmodule CommandedIssue556 do
  def reset_event_store! do
    config = CommandedIssue556.EventStore.config()

    {:ok, conn} = Postgrex.start_link(config)

    EventStore.Storage.Initializer.reset!(conn, config)
  end
end
