fizzy = fn
  0, 0, _ -> "FizzBuzz"
  0, _, _ -> "Fizz"
  _, 0, _ -> "Buzz"
  _, _, c -> c
end

funky = fn
  x -> fizzy.(rem(x,3), rem(x,5), x)
end

IO.puts funky.(10)
IO.puts funky.(11)
IO.puts funky.(12)
IO.puts funky.(13)
IO.puts funky.(14)
IO.puts funky.(15)
IO.puts funky.(16)
