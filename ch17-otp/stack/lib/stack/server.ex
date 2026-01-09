defmodule Stack.Server do
  use GenServer

  def init(initial_stack) do
    {:ok, initial_stack}
  end

  def handle_call(:pop, _from, []) do
    {:reply, :stack_empty, []}
  end

  def handle_call(:pop, _from, stack) do
    [top | rest] = stack
    {:reply, {:ok, top}, rest}
  end

  def handle_call(:peek, _from, stack) do
    [top | _rest] = stack
    {:reply, {:ok, top}, stack}
  end

  def handle_call(:print, _from, stack) do
    {:reply, {:ok, inspect(stack)}, stack}
  end

  def handle_cast({:push, item}, stack) do
    {:noreply, [item | stack]}
  end
end
