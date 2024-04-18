defmodule CommandedIssue556.TestEvent do
  @derive Jason.Encoder
  defstruct [:test_id, :number]
end
