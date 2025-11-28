defmodule AnagramCheck do
  # Takes 2 charlists
  def anagram?(word1, word2) do
    a = word1 -- word2
    b = word2 -- word1
    _anagram?(a, b)
  end
  defp _anagram?([], []), do: true
  defp _anagram?(_a, _b), do: false
end
