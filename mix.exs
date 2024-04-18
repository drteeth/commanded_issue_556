defmodule CommandedIssue556.MixProject do
  use Mix.Project

  def project do
    [
      app: :commanded_issue_556,
      version: "0.1.0",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {CommandedIssue556.Application, []}
    ]
  end

  defp deps do
    [
{:jason, "~> 1.2"},
      {:commanded, "~> 1.4"},
      {:commanded_eventstore_adapter, "~> 1.4"},
      {:uuid, "~> 1.1"}
    ]
  end
end
