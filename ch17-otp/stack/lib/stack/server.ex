defmodule Stack.Server do
  use GenServer

  def init(initial_stack) do
    {:ok, initial_stack}
  end

  def handle_call(:pop, _from, []) do
    {:reply, :stack_empty, []}
  end

  def handle_call(:pop, _from, [top | rest]) do
    {:reply, {:ok, top}, rest}
  end

  def handle_call({:push, item}, _from, stack) do
    {:reply, {:ok, "#{item} added"}, [item | stack]}
  end

  def handle_call(:print, _from, stack) do
    {:reply, {:ok, "#{inspect(stack)}"}, stack}
  end 
end

# iex> {:ok, pid} = GenServer.start_link(Stack.Server, [69, 666, "usurper", 7, 11])
# {:ok, #PID<0.148.0>}
# iex> GenServer.call(pid, :pop)
# {:ok, 69}
# iex> GenServer.call(pid, {:push, "oink oink"})
# {:ok, "oink oink added"}
# iex> GenServer.call(pid, :print)
# {:ok, "[\"oink oink\", 666, \"usurper\", 7, 11]"}
