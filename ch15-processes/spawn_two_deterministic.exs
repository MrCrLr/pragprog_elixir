defmodule SpawnTwoProcesses do
  def greet do
    receive do
      {sender, token, msg} ->
        send(sender, {:ok, token, self(), msg})
        greet()
    end
  end
end

comms = [ 
  { spawn(SpawnTwoProcesses, :greet, []), 1, "Fred" }, 
  { spawn(SpawnTwoProcesses, :greet, []), 0, "Betty" },
]

Enum.each(comms, fn { pid, token, msg } -> 
  send(pid, {self(), token, "Hello, #{msg}!"})
end)

results = 
  for _ <- 1..length(comms), reduce: %{} do
    acc -> 
      receive do
        {:ok, token, from_pid, msg} ->
          IO.puts("received token=#{token} from=#{inspect(from_pid)} msg=#{msg}") 
          Map.put(acc, token, {from_pid, msg})
      end
  end

results
|> Enum.sort_by(fn {token, _msg} -> token end)
|> Enum.each(fn {token, {from_pid, msg}} -> 
  IO.puts("printing token=#{token} from=#{inspect(from_pid)} msg=#{msg}") 
end)
