add_two = Enum.map [1,2,3,4], &(&1 + 2)

num_check = Enum.each add_two, &IO.inspect/1

IO.puts num_check

IO.inspect add_two
