defmodule CommandedIssue556.TestEventHandler do
  use Commanded.Event.Handler,
    application: CommandedIssue556.TestApp,
    name: "test-event-handler",
    concurrency: 5

  alias CommandedIssue556.TestEvent

  def init(config) do
    test = Keyword.get(config, :state)
    config = Keyword.put(config, :state, {test, Keyword.get(config, :index)})
    {:ok, config}
  end

  def handle(%TestEvent{} = event, %{state: {table, index}}) do
    if event.number == 6 do
      {:error, :bad_number}
    else
      true = :ets.insert(table, {event.test_id, event.number, index})
      :ok
    end
  end

  def get_inserts(table) do
    :ets.tab2list(table)
  end
end
