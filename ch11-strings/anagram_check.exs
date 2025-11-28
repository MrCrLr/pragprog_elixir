defmodule AnagramCheck do
  # Takes two charlists or binaries or any combination
  def anagram?(word1, word2) 
  when is_binary(word1) and is_binary(word2) do
    a = String.to_charlist(word1)
    b = String.to_charlist(word2)
    anagram?(a, b)
  end
  
  def anagram?(word1, word2) 
  when is_binary(word1) and is_list(word2) do
    a = String.to_charlist(word1)
    b = word2  
    anagram?(a, b)
  end

  def anagram?(word1, word2) 
  when is_list(word1) and is_binary(word2) do
    a = word1
    b = String.to_charlist(word2)
    anagram?(a, b)
  end  
    
  def anagram?(word1, word2) do
    a = word1 -- word2
    b = word2 -- word1
    _anagram?(a, b)
  end

  defp _anagram?([], []), do: true
  defp _anagram?(_a, _b), do: false
end

