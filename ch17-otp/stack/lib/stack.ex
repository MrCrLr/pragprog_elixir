defmodule Stack do
  @server Stack.Server

  def start_link(items) do
    GenServer.start_link(@server, items, name: @server)
  end

  def pop(),      do: GenServer.call(@server, :pop)
  def peek(),     do: GenServer.call(@server, :peek)
  def snapshot(), do: GenServer.call(@server, :snapshot)
  def push(item), do: GenServer.cast(@server, {:push, item})
  def quit(),     do: GenServer.stop(@server, :normal) 
end

