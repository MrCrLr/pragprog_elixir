defmodule CSVParser do
  def parse(file) do
    { :ok, f } = File.open(file)
    keys = 
      f 
      |> IO.read(:line)
      |> String.trim()
      |> String.split(",")
      |> Enum.map(&String.to_atom/1)    
    rows = 
      IO.stream(f, :line)
      |> Enum.map(&parse_row(&1, keys))

    rows
  end

  defp parse_row(line, keys) do
    values =
      line
      |> String.trim()
      |> String.split(",")
    keys
    |> Enum.zip(values)
    |> Enum.map(&convert/1)
  end

  defp convert({:id, v}), do: {:id, String.to_integer(v)}
  defp convert({:ship_to, v}) do 
    cleaned = String.trim_leading(v, ":")
    {:ship_to, String.to_atom(cleaned)}
  end
  defp convert({:net_amount, v}), do: {:net_amount, Float.round(String.to_float(v), 2)}
end    

