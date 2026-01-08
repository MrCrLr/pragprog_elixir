defmodule Sequence.Server do
  use GenServer

  def init(initial_number) do
    {:ok, initial_number}
  end

  def handle_call(:next_number, _from, current_number) do
    {:reply, current_number, current_number + 1}
  end

  def handle_call({:set_number, new_number}, _from, _current_number) do
    {:reply, new_number, new_number}
  end

  def handle_call({:range, number}, _, _) do
    {:reply, {:range_to, 
              number, 
              Enum.map(1..number, fn x -> 
                       x * 2 end)}, []}
  end
end
