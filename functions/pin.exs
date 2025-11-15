defmodule Greeter do
  def for(name, greeting) do
    fn
      (^name) -> "#{greeting} #{name}"
      (_) -> "I don't know you."
    end
  end
end

mr_reed = Greeter.for("Lou", "Yo!")

IO.puts mr_reed.("Lou")
IO.puts mr_reed.("Nick")
