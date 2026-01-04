defmodule SpawnTwoProcesses do
  def greet() do
    receive do
      {sender, msg} ->
        send(sender, {:ok, "Hello, #{msg}" })
        greet()
    end
  end
end

pids = [ 
  { spawn(SpawnTwoProcesses, :greet, []), "Fred" }, 
  { spawn(SpawnTwoProcesses, :greet, []), "Betty" },
]

Enum.each(pids, fn { pid, name } -> 
  send(pid, {self(), "#{name}!"})
end)

for _ <- 1..length(pids) do
  receive do
    {:ok, message} -> IO.puts(message)
  end
end
