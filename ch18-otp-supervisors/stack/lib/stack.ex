defmodule Stack do
  @server Stack.Server

  def pop(),      do: GenServer.call(@server, :pop)
  def peek(),     do: GenServer.call(@server, :peek)
  def snapshot(), do: GenServer.call(@server, :snapshot)
  def quit(),     do: GenServer.call(@server, :quit) 
  def crash(),    do: GenServer.cast(@server, :crash)
  def push(item), do: GenServer.cast(@server, {:push, item})
end

