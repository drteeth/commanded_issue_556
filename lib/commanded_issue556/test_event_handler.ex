defmodule CommandedIssue556.TestEventHandler do
  use Commanded.Event.Handler,
    application: CommandedIssue556.TestApp,
    name: "test-event-handler",
    concurrency: 5

  alias CommandedIssue556.TestEvent

  def handle(%TestEvent{} = event, %{state: state}) do
    test = Keyword.fetch!(state, :test)

    if fail?(state, event) do
      {:error, :bad_number}
    else
      send(test, {:handled, event.number})
      :ok
    end
  end

  defp fail?(state, event) do
    fail_on = Keyword.fetch!(state, :fail_on)
    event.number == fail_on
  end
end
