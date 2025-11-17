people = [
         %{ name: "Llewelyn", height: 0.91 },
         %{ name: "Nicky", height: 1.89 },
         %{ name: "Jenny", height: 1.59 },
         %{ name: "Egon", height: 1.22 },
         %{ name: "Ysa", height: 1.35 }
         ]

defmodule HotelRoom do
  def book(%{name: name, height: height})
  when height > 1.8 do
    IO.puts "Need extra-long bed for #{name}"
  end

  def book(%{name: name, height: height})
  when height < 1.3 do
    IO.puts "Need low shower controls for #{name}"
  end

  def book(person) do
    IO.puts "Need regular bed for #{person.name}"
  end
end

people |> Enum.each(&HotelRoom.book/1)
