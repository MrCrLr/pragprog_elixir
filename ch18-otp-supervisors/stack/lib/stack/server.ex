defmodule Stack.Server do
  use GenServer
  alias Stack.Impl

  def start_link(initial_stack) do
    GenServer.start_link(__MODULE__, initial_stack, name: __MODULE__)
  end

  def init(initial_stack) do
    {:ok, initial_stack}
  end

  def handle_call(:pop, _from, stack) do
    Impl.pop(stack)
  end

  def handle_call(:peek, _from, stack) do
    Impl.peek(stack)
  end

  def handle_call(:snapshot, _from, stack) do
    Impl.snapshot(stack)
  end

  def handle_cast({:push, item}, stack) do
    Impl.push(item, stack)
  end
  
  def terminate(reason, stack) do
    Impl.report(reason, stack)
    :ok
  end
end

