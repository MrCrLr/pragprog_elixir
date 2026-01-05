defmodule Fib do
  @spec fib(non_neg_integer()) :: non_neg_integer()
  def fib(n) when is_integer(n) and n >= 0 do
    do_fib(n, 0, 1)
  end

  # do_fib(remaining_steps, a, b)
  # Invariant: a == fib(original_n - remaining_steps)
  #            b == fib(original_n - remaining_steps + 1)
  defp do_fib(0, a, _b), do: a
  defp do_fib(n, a, b), do: do_fib(n - 1, b, a + b)
end

IO.puts(Fib.fib(0))  # 0
IO.puts(Fib.fib(1))  # 1
IO.puts(Fib.fib(5))  # 5
IO.puts(Fib.fib(10)) # 55
