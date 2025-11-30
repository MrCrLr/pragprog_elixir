defmodule OK do
  @doc """
  Unwraps an `{:ok, value}` tuple or raises a helpful error for an 
  `{:error, reason}` tuple. Works for any operation: file IO, HTTP calls,
  parsing, etc.
  """
  def ok!({:ok, value}), do: value

  # Handle commonf file/IO errors (__ENOENT__, permission, etc)  
  def ok!({:error, reason}) when is_atom(reason) do
    message = format_reason(reason) 
    raise "Operation failed: #{message}"
  end

  # Handle errors with more complex details
  def ok!({:error, reason}) do
    raise "Operation failed: #{inspect(reason)}"
  end

  # Catch-all for unexpected inputs
  def ok!(other) do
    raise "Unexpected {:ok, value} or {:error, reason}, got: #{inspect(other)}"
  end

  # Format common filesystem errors
  defp format_reason(reason) do
    :file.format_error(reason)
    |> to_string()
    |> String.capitalize()
  end
end
