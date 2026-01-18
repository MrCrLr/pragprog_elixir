defmodule Stack.Server do
  use GenServer, restart: :transient
  alias Stack.Impl
  alias Stack.Stash

  def start_link(opts \\ []) do
    name = Keyword.get(opts, :name, __MODULE__)
    GenServer.start_link(__MODULE__, nil, name: name)
  end

  def init(_) do
    stash = Application.get_env(:stack, :stash, Stash)
    {:ok, Stash.get(stash)}
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

