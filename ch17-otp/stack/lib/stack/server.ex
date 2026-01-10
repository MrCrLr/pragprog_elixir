defmodule Stack.Server do
  use GenServer
  alias Stack.Impl

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

