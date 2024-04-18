defmodule CommandedIssue556.TestApp do
  use Commanded.Application,
    otp_app: :commanded_issue_556,
    event_store: Application.compile_env!(:commanded_issue_556, :event_store)


  defmodule TestRouter do
    use Commanded.Commands.Router

    dispatch(CommandedIssue556.TestCommand, to: CommandedIssue556.TestAggregate, identity: :test_id)
  end

  router(TestRouter)
end
