defmodule Stack.Server do
  use GenServer, restart: :transient
  alias Stack.Impl
  alias Stack.Stash

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def init(_) do
    {:ok, Stash.get()}
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

  def handle_call(:quit, from, stack) do
    Impl.quit(from, stack)
    {:stop, :normal, :ok, stack}
  end

  def handle_cast(:crash, stack) do
    Impl.crash({self(), :cast}, stack)
    {:stop, :boom, stack}
  end

  def handle_cast({:push, item}, stack) do
    Impl.push(item, stack)
  end
  
  def terminate(_reason, stack) do
    Stash.update(stack)
    :ok
  end
end

