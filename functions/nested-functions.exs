# Functions can return functions
fun_guy = fn -> (fn -> "Mushrooms!" end) end

other = fun_guy.()

IO.puts other.()


# Functions remember their original environment
greeter = fn name -> (fn -> "Hello #{name}" end) end

lou_greeter = greeter.("Lou")

IO.puts lou_greeter.()


# Exercise: Functions-4
# Parameterized functions
yum = fn snack ->
  fn attack -> "Time for #{snack}" <> " " <> "#{attack}!" end
end

hungry = yum.("buttery")

IO.puts hungry.("popcorn")

IO.puts yum.("chocolatey").("almonds")
