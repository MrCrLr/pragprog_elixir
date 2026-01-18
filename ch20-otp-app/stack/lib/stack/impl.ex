defmodule Stack.Impl do
  
  def pop([]),                 do: {:reply, :stack_empty, []}
  def pop([top | rest]),       do: {:reply, {:ok, top}, rest}
  def peek([]),                do: {:reply, :stack_empty, []}
  def peek([top | _] = stack), do: {:reply, {:ok, top}, stack}
  def snapshot(stack),         do: {:reply, {:ok, stack}, stack} 
  def push(item, stack),       do: {:noreply, [item | stack]}
  def quit(from, stack),       do: report(:quit, from, stack)
  def crash(from, stack),      do: report(:crash, from, stack)

  defp report(msg, from, stack) do
    case msg do 
      :crash -> 
        IO.puts("Program crashed. Restarting...")
        IO.puts("  from:  #{inspect(from)}")
        IO.puts("  state: #{inspect(stack)}")
        IO.puts("Retaining current state.")
      :quit  -> 
        IO.puts("Program exiting...")
        IO.puts("  from:  #{inspect(from)}")
        IO.puts("  state: #{inspect(stack)}")
        IO.puts("Cleaning up stack...")
        cleanup(stack)
    end
  end

  defp cleanup(_stack),         do: :ok
end

