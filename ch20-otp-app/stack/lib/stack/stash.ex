defmodule Stack.Stash do
  use GenServer, restart: :transient

  @me __MODULE__

  def start_link(initial_stack, opts \\ []) do
    name = Keyword.get(opts, :name, @me)
    GenServer.start_link(__MODULE__, initial_stack, name: name)
  end

  def get(server \\ @me) do
    GenServer.call(server, {:get})
  end

  def update(server \\ @me, new_stack) do
    GenServer.cast(server, {:update, new_stack})
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

