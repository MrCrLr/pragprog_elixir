defmodule Stack do
  @server Stack.Server

  def start_link(items) do
    GenServer.start_link(@server, items, name: @server)
  end

  def pop(),      do: GenServer.call(@server, :pop)
  def push(item), do: GenServer.cast(@server, {:push, item})
  def peek(),     do: GenServer.call(@server, :peek)
  def print(),    do: GenServer.call(@server, :print)

end
