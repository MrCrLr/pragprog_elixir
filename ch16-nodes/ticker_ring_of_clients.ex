defmodule Ticker do

  @name :ticker

  def start do
    pid = spawn(__MODULE__, :generator, [{nil, nil}])
    :global.register_name(@name, pid)
  end

  def register(client_pid) do
    send :global.whereis_name(@name), { :register, client_pid }
  end

  def generator({head, tail}) do
    receive do
      { :register, client} ->
        IO.puts "registering #{inspect client}"

        cond do
          head == nil ->
            # FIRST client: points to itself (ring of 1)
            send(client, {:set_next, client})
            # start the token
            send(client, {:tick})
            generator({client, client})

          true ->
            # later clients: insert at end: tail -> client -> head
            send(client, {:set_next, head})
            send(tail, {:set_next, client})
            generator({head, client})
        end
    end
  end
end
  

defmodule Client do
  @interval 2000

  def start do
    pid = spawn(__MODULE__, :receiver, [nil])
    Ticker.register(pid)
  end

  def receiver(next) do
    receive do
      {:set_next, pid} ->
        receiver(pid)

      {:tick} ->
        IO.puts("tock in client #{inspect(self())}")
        tick_wait(pid)
    end
  end

  # while holding the token, wait 2s BUT still accept link updates
  defp tick_wait(next) do
    receive do
      {:set_next, pid} ->
        tick_wait(pid)
    after
      @interval ->
        send(next, {:tick})
        receiver(next)
    end
  end
end
