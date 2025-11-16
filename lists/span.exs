# Exercise 4: Lists and Recusion
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
