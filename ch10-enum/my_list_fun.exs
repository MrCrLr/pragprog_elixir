defmodule MyListFun do

  def flatten(list), do: deep(list, [], [])

  defp deep([], [], acc), do: Enum.reverse(acc)

  defp deep([], rem, acc), do: deep(rem, [], acc)

  defp deep([h | t], rem, acc) 
    when Kernel.is_list(h) do
    deep(h, t ++ rem, acc)
  end

  defp deep([h | t], rem, acc) do
    deep(t, rem, [h | acc])
  end
end
