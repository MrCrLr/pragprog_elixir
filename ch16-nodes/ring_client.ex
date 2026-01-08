defmodule RingClient do

  @interval 2000

  def start do
    spawn(__MODULE__, :loop, [self(), []])
  end

  def loop(next, pending) do
    receive do
      {:set_next, pid} ->
        loop(pid, pending)

      {:join, new_pid} ->
        loop(next, pending ++ [new_pid])

      {:tick} ->
        IO.puts("tock #{inspect(self())}")

        {next2, pending2} = splice_in_joins(next, pending)

        token_wait(next2, pending2)
    end
  end

  defp token_wait(next, pending) do
    receive do
      {:set_next, pid} ->
        token_wait(pid, pending)

      {:join, new_pid} ->
        token_wait(next, pending ++ [new_pid])
    after
      @interval ->
        send(next, {:tick})
        loop(next, pending)
    end
  end

  defp splice_in_joins(next, []), do: {next, []}

  defp splice_in_joins(next, [new | rest]) do
    # Insert one new node right after me:
    # new.next = current next
    send(new, {:set_next, next})

    # and my next becomes new
    splice_in_joins(new, rest)
  end
end
