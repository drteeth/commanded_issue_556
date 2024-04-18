defmodule CommandedIssue556.TestAggregate do
  defstruct [:test_id, :number]

  alias CommandedIssue556.TestEvent

  def execute(_state, command) do
    %TestEvent{
      test_id: command.test_id,
      number: command.number
    }
  end

  def apply(state, event) do
    %{state | test_id: event.test_id, number: event.number}
  end
end
