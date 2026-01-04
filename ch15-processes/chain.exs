"""
$ elixir -r chain.exs -e "Chain.run(10)"
i{1987, "Result is 10"}
$ elixir -r chain.exs -e "Chain.run(100)"
{1948, "Result is 100"}
$ elixir -r chain.exs -e "Chain.run(1000)"
{2894, "Result is 1000"}
$ elixir -r chain.exs -e "Chain.run(10000)"
{14308, "Result is 10000"}
$ elixir -r chain.exs -e "Chain.run(400000)"
{594795, "Result is 400000"}
$ elixir -r chain.exs -e "Chain.run(1000000)"
{1655717, "Result is 1000000"}
$ elixir -r chain.exs -e "Chain.run(10000000)"

07:06:25.075 [error] Too many processes

** (SystemLimitError) a system limit has been reached
    :erlang.spawn(Chain, :counter, [#PID<0.1048675.0>])
    chain.exs:10: anonymous fn/2 in Chain.create_processes/1
    (elixir 1.19.4) lib/enum.ex:4562: Enum.reduce_range/5
    chain.exs:13: Chain.create_processes/1
    (stdlib 7.1) timer.erl:658: :timer.tc/4
    chain.exs:24: Chain.run/1
    nofile:1: (file)

$ elixir --erl "+P 10000000" -r chain.exs -e "Chain.run(10_000_000)"
{24271759, "Result is 10000000"}

"""

defmodule Chain do
  def counter(next_pid) do
    receive do
      n -> send(next_pid, n + 1)
    end
  end

  def create_processes(n) do
    code_to_run = fn (_, send_to) ->
      spawn(Chain, :counter, [send_to])
    end
    
    last = Enum.reduce(1..n, self(), code_to_run)

    send(last, 0) # start count by sending a zero to last process

    receive do    # wait for result to come back
      final_answer when is_integer(final_answer) ->
        "Result is #{inspect(final_answer)}"
    end
  end

  def run(n) do
    :timer.tc(Chain, :create_processes, [n])
    |> IO.inspect
  end
end
