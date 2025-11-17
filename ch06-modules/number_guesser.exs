defmodule Chop do
  def guess(num, a..b//_) when a <= b do
    mid = div(a + b, 2)
    IO.puts("Is it #{mid}?")
    match(num, mid, a..b)
  end

  defp match(num, mid, _) when num == mid do
    IO.puts("#{mid}")
  end

  defp match(num, mid, _..b//_) when num > mid do
    guess(num, (mid + 1)..b)
  end

  defp match(num, mid, a.._//_) when num < mid do
    guess(num, a..(mid - 1))
  end
end
