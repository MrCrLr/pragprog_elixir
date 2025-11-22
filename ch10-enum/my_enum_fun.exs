defmodule MyEnumFun do

  # all?
  def all?([], _func), do: true
  def all?([ head | tail ], func) do
    if func.(head) do
      all?(tail, func)
    else
      false
    end
  end

  # each
  def each([], _func), do: []
  def each([ head | tail ], func) do
    [ func.(head) | each(tail, func) ]
  end

  # filter
  def filter([], _func), do: []
  def filter([ head | tail ], func) do
    if func.(head) do
      [ head | filter(tail, func) ]
    end
  end

  # split
  def split(list, index), do: splitter(list, index, [])
  defp splitter(rest, 0, acc) do
    { reverse(acc), rest }
  end
  defp splitter([ head | tail ], index, acc) when index > 0 do
    splitter(tail, index - 1, [ head | acc ])
  end
  defp splitter([], _index, acc) do
    { reverse(acc), [] }
  end
  defp reverse(list), do: reverse(list, [])
  defp reverse([], acc), do: acc
  defp reverse([ head | tail ], acc) do
    reverse(tail, [ head | acc ])
  end

  # take
  def take(list, num) when num < 0 do 
    taker(reverse(list), -num, [], :neg)
  end

  def take(list, num) do 
    taker(list, num, [], :pos)
  end

  defp taker([], _num, acc, :pos), do: reverse(acc)
  defp taker([], _num, acc, :neg), do: acc

  defp taker(_, 0, acc, :pos), do: reverse(acc)
  defp taker(_, 0, acc, :neg), do: acc

  defp taker([head | tail], num, acc, flag) do
    taker(tail, num - 1, [head | acc], flag)
  end
end
