defmodule MyList do
  def len([]), do: 0
  def len([ _head | tail ]), do: 1 + len(tail)

  def square([]), do: []
  def square([ head | tail ]), do: [ head * head | square(tail) ]

  def add_1([]), do: []
  def add_1([ head | tail ]), do: [ head + 1 | add_1(tail) ]

  def map([], _func), do: []
  def map([ head | tail ], func), do: [ func.(head) | map(tail, func) ]

  def reduce([], value, _) do
    value
  end
  def reduce([ head | tail ], value, func) do
    reduce(tail, func.(head, value), func)
  end

  # Apply function to each item in list
  def mapsum([], _func), do: 0
  def mapsum([ head | tail ], func) do
    func.(head) + mapsum(tail, func)
  end

  # Find max value in list
  def compare(a, b) when a >= b, do: a
  def compare(a, b) when a < b, do: b
  def maxitout([]), do: 0
  def maxitout([ head | tail ]) do
    compare(head, maxitout(tail))
  end

  # Caesar cipher decryption :)
  def caesar([], _shift), do: []

  def caesar([ h | t ], shift) do
    [rotate(h, shift) | caesar(t, shift)]
  end

  defp rotate(char, shift) when char in ?a..?z do
    offset = char - ?a
    rotated = rem(offset + shift, 26)
    rotated + ?a
  end

  defp rotate(char, _shift), do: char
end

