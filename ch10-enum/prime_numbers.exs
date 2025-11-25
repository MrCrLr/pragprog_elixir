defmodule PrimeNumbers do
  def prime(n) when n < 2, do: "No valid prime numbers"
  def prime(n) do
    numlist = Spanner.span(2, n)
    for num <- numlist, is_prime?(num), do: num
  end
  defp is_prime?(num) when num <= 3, do: true
  defp is_prime?(num) do
    divs = for div <- 2..trunc(:math.sqrt(num)), 
           rem(num, div) == 0, do: div
    no_divisors?(divs)
  end
  defp no_divisors?([]), do: true
  defp no_divisors?(_divs), do: false
end

defmodule Spanner do
  def span(a, b) when a == b do
    [ a | [] ] # Add tail when done
  end
  def span(a, b) when a < b do
    [ a | span(a + 1, b) ]
  end
  def span(a, b) when a > b do
    [ a | span(a - 1, b) ]
  end
end
