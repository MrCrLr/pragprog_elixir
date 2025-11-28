defmodule AsciiCheck do
  def valid([]), do: true
  def valid([h | t]) when h in 32..126 do
    valid(t)
  end
  def valid([_]), do: false
end 
