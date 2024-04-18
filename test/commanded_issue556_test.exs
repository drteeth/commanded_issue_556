defmodule CommandedIssue556Test do
  use ExUnit.Case

  alias CommandedIssue556.TestApp
  alias CommandedIssue556.TestCommand
  alias CommandedIssue556.TestEventHandler

  test "it handles events concurrently", %{test: test} do
    # Given a test data table
    :ets.new(test, [:duplicate_bag, :public, :named_table])

    # And 20 events to handle
    test_id = UUID.uuid1()

    for n <- 1..20 do
      command = %TestCommand{test_id: test_id, number: n}
      :ok = TestApp.dispatch(command)
    end

    # When we start the event handler, which will fail to handle event number 6
    start_supervised!({TestEventHandler, state: test})

    # And we give it a moment to run
    :timer.sleep(500)

    # And we ask the table which events were handled
    results =
      TestEventHandler.get_inserts(test)
      |> Enum.map(&elem(&1, 1))
      |> Enum.uniq()
      |> Enum.sort()

    # Then what should we see? That all events were handled?
    # Should the handler fail on event number 6 every time or just once?
    assert results == Enum.to_list(1..20)
  end
end
