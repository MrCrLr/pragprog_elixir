defmodule Stack.MixProject do
  use Mix.Project

  def project do
    [
      app: :stack,
      version: "0.0.1",
      elixir: "~> 1.19",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod:        { Stack.Application, [] },
      env:        [initial_stack: [69, 2600, "usurper", 7, 11]],
      registered: [ Stack.Server, ],
      extra_applications: [:logger],
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    []
  end
end
