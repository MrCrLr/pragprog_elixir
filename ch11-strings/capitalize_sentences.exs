defmodule Capitalizer do
  import String, only: [trim: 1, downcase: 1, upcase: 1]
  
  def capitalize(sentence) do
    s = sentence |> trim() |> downcase()
    format(s, nil)
  end
  
  # Base cases
  defp format(<<>>, acc), do: acc
  defp format(".", acc),  do: acc <> "."

  # First character of sequence
  defp format(<<h::utf8, t::binary>>, acc) when acc == nil do
    format(t, upcase(<<h::utf8>>))
  end
  
  # After ". " capitalize next character
  defp format(<<". ", h::utf8, t::binary>>, acc) do
    format(t, acc <> ". " <> upcase(<<h::utf8>>))
  end

  # Default case
  defp format(<<h::utf8, t::binary>>, acc) do
    format(t, acc <> <<h::utf8>>)
  end
end
