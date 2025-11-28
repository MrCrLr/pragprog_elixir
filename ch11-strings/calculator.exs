defmodule Calculator do
  def calculate(input) do
    { a, b, op } = parse(input, nil, nil, nil)
    apply_op(a, b, op)
  end
  defp apply_op(a, b, ?+), do: a + b
  defp apply_op(a, b, ?-), do: a - b
  defp apply_op(a, b, ?*), do: a * b
  defp apply_op(a, b, ?/), do: a / b
    
  defp parse([], a, b, op), do: { a, b, op }

  defp parse([h | t], a, b, op) when h == 32 do
    parse(t, a, b, op)
  end

  defp parse([h | t], a, b, _op) when h in [?+,?-,?*,?/] do
    parse(t, a, b, h)
  end
 
  defp parse([h | t], a, b, op) when h in ?0..?9 and a == nil do
    parse(t, h - ?0, b, op) 
  end

  defp parse([h | t], a, b, op) when h in ?0..?9 and op == nil do
    digit = h - ?0
    parse(t, a * 10 + digit, b, op) 
  end

  defp parse([h | t], a, b, op) when h in ?0..?9 and b == nil do
    parse(t, a, h - ?0, op) 
  end

  defp parse([h | t], a, b, op) when h in ?0..?9 and b != nil do
    digit = h - ?0
    parse(t, a, b * 10 + digit, op) 
  end
end
