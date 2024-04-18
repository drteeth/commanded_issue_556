defmodule CommandedIssue556.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      CommandedIssue556.TestApp
    ]

    opts = [strategy: :one_for_one, name: CommandedIssue556.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
