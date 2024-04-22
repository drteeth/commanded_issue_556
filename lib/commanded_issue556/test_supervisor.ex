defmodule CommandedIssue556.TestSupervisor do
  use Supervisor, restart: :temporary

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def init(opts) do
    children = [
      {CommandedIssue556.TestEventHandler, opts}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
