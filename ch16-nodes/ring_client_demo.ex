defmodule Client do
  @interval 2000

  # Start a client with no `next` yet (Ring will set it).
  def start do
    spawn(__MODULE__, :loop, [nil])
  end

  # State = next_pid
  def loop(next) do
    receive do
      {:set_next, pid} ->
        loop(pid)

      {:tick} ->
        IO.puts("tock #{inspect(self())}")
        wait_and_forward(next)
    end
  end

  # While holding the token, wait 2 seconds, but still accept :set_next updates
  defp wait_and_forward(next) do
    receive do
      {:set_next, pid} ->
        wait_and_forward(pid)
    after
      @interval ->
        if is_pid(next), do: send(next, {:tick})
        loop(next)
    end
  end
end

defmodule Ring do
  @name :ring

  # Start the "wiring coordinator" (not a ticker)
  def start do
    pid = spawn(__MODULE__, :loop, [{nil, nil}]) # {head, tail}
    :global.register_name(@name, pid)
    pid
  end

  # Add an already-started client pid into the ring
  def join(client_pid) do
    send(:global.whereis_name(@name), {:join, client_pid})
    client_pid
  end

  # Convenience: spawn a client and join it
  def join_new do
    Client.start() |> join()
  end

  # State = {head, tail}
  # Invariant: tail.next -> head (when ring non-empty)
  def loop({head, tail}) do
    receive do
      {:join, pid} ->
        IO.puts("joining #{inspect(pid)}")

        cond do
          head == nil ->
            # first client: points to itself, then start the token
            send(pid, {:set_next, pid})
            send(pid, {:tick})
            loop({pid, pid})

          true ->
            # insert at end: tail -> pid -> head
            send(pid, {:set_next, head})
            send(tail, {:set_next, pid})
            loop({head, pid})
        end
    end
  end
end

defmodule Demo do
  def run do
    Ring.start()

    Ring.join_new()
    Ring.join_new()
    Ring.join_new()

    # Can add more later — it will splice into the ring:
    # :timer.sleep(7000)
    # Ring.join_new()
  end
end

# Demo.run()
