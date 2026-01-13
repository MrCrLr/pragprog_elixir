defmodule Stack.Stash do
  use GenServer

  @me __MODULE__

  def start_link(initial_stack) do
    GenServer.start_link(__MODULE__, initial_stack, name: @me)
  end

  def get() do
    GenServer.call(@me, {:get})
  end

  def update(new_stack) do
    GenServer.cast(@me, {:update, new_stack})
  end

  # Stash server implementation
  
  def init(initial_stack) do
    {:ok, initial_stack}
  end

  def handle_call({:get}, _from, stack) do
    {:reply, stack, stack}
  end

  def handle_cast({:update, new_stack}, _stack) do
    {:noreply, new_stack}
  end
end

