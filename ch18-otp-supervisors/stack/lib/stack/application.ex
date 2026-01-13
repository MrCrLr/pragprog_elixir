defmodule Stack.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {Stack.Stash, [69, 666, "usurper", 7, 11]},
      {Stack.Server, nil},
    ]

    opts = [strategy: :one_for_one, name: Stack.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
