defmodule Duper.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
       Duper.Results,
      {Duper.PathFinder, "/Users/nickstevens/Library/Mobile Documents/com~apple~CloudDocs"},
       Duper.WorkerSupervisor,
      {Duper.Gatherer, 8},
    ]

    opts = [strategy: :one_for_all, name: Duper.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
