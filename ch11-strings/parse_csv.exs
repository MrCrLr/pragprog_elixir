defmodule CSVParser do
import String, 
  only: [split: 2, to_atom: 1, to_float: 1, 
         to_integer: 1, trim: 1, trim_leading: 2]
import Float, 
  only: [round: 2]

  def parse(file) do
    f = File.open!(file)
    keys = 
      f 
      |> IO.read(:line)
      |> trim()
      |> split(",")
      |> Enum.map(&to_atom/1)    
    rows = 
      IO.stream(f, :line)
      |> Enum.map(&parse_row(&1, keys))

    rows
  end

  defp parse_row(line, keys) do
    values =
      line
      |> trim()
      |> split(",")
    keys
    |> Enum.zip(values)
    |> Enum.map(&convert/1)
  end

  defp convert({:id, v}),         do: {:id, to_integer(v)}
  defp convert({:ship_to, v}),    do: {:ship_to, v |> trim_leading(":") |> to_atom()}
  defp convert({:net_amount, v}), do: {:net_amount, v |> to_float() |> round(2)}
end    

