defmodule CommandedIssue556Test do
  use ExUnit.Case

  alias CommandedIssue556.TestApp
  alias CommandedIssue556.TestCommand
  alias CommandedIssue556.TestSupervisor

  setup do
    CommandedIssue556.reset_event_store!()

    config = CommandedIssue556.EventStore.config()

    [conn: start_supervised!({Postgrex, config})]
  end

  test "it handles all events concurrently", %{conn: conn} do
    # Given we dispatch 20 commands to a stream
    stream_id = UUID.uuid1()

    for n <- 1..20 do
      command = %TestCommand{test_id: stream_id, number: n}
      :ok = TestApp.dispatch(command)
    end

    # When we start an event handler which will fail to handle the 6th event
    start_supervised!({TestSupervisor, state: [test: self(), fail_on: 6]})

    # Then we expect at least the first 5 events to be handled.
    for n <- 1..5 do
      assert_receive {:handled, ^n}
    end

    # HACK: Give the handler time to finish whatever it's going to do
    :timer.sleep(50)

    # And we expect the subscription to be at the 5th event
    assert get_last_seen(conn) == 5
  end

  defp get_last_seen(conn) do
    case Postgrex.query!(conn, "select last_seen from subscriptions", []) do
      %{rows: [[last_seen]]} ->
        last_seen

      %{rows: []} ->
        0
    end
  end
end
