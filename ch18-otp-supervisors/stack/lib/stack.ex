defmodule Stack do
  @server Stack.Server

  def pop(),      do: GenServer.call(@server, :pop)
  def peek(),     do: GenServer.call(@server, :peek)
  def snapshot(), do: GenServer.call(@server, :snapshot)
  def push(item), do: GenServer.cast(@server, {:push, item})
  def quit(),     do: GenServer.stop(@server, :normal) 
end

