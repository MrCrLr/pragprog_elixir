defmodule Center do
  def center(wordlist) do
    max_len = 
      Enum.reduce(wordlist, 0, fn word, curr_max -> 
        word_len = String.length(word)
        max(word_len, curr_max)
      end)
    _center(wordlist, max_len)
  end

  def _center([], _max_len), do: :ok

  def _center([head | tail], max_len) do
    curr_len = String.length(head)
    padding = div(max_len - curr_len, 2) + curr_len 
    curr_word = String.pad_leading(head, padding, ".") 
      |> String.pad_trailing(max_len, ".")
    print(curr_word)
    _center(tail, max_len)
  end

  defp print(word) do
    IO.puts(word)
  end

end
