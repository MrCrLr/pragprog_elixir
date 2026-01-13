defmodule Stack.Impl do
  
  def pop([]),                 do: {:reply, :stack_empty, []}
  def pop([top | rest]),       do: {:reply, {:ok, top}, rest}
  def peek([]),                do: {:reply, :stack_empty, []}
  def peek([top | _] = stack), do: {:reply, {:ok, top}, stack}
  def snapshot(stack),         do: {:reply, {:ok, stack}, stack} 
  def push(item, stack),       do: {:noreply, [item | stack]}
  def quit(from, stack),       do: report(from, stack)

  defp report(from, stack) do
    IO.puts("Program quit by user.")
    IO.puts("  from:  #{inspect(from)}")
    IO.puts("  state: #{inspect(stack)}")
    cleanup(stack)
  end
  defp cleanup(_stack),         do: :ok
end

