import String, only: [contains?: 2, downcase: 1, upcase: 1]

authors = [
  %{ name: %{ first: "Neal", last: "Stephenson"}, book: "Snow Crash" },
  %{ name: %{ first: "William", last: "Gibson" }, book: "Neuromancer" },
  %{ name: %{ first: "Cormac", last: "McCarthy" }, book: "Blood Meridian" },
  %{ name: %{ first: "William", last: "Burroughs" }, book: "Naked Lunch" },
  %{ name: %{ first: "Kurt", last: "Vonnegut" }, book: "The Sirens of Titan" },
  %{ name: %{ first: "H. G.", last: "Wells" }, book: "The War of the Worlds" },
  %{ name: %{ first: "Philip", last: "Dick" }, book: "VALIS" },
  %{ name: %{ first: "Douglas", last: "Adams" }, book: "The Hitchhiker's Guide to the Galaxy" },
  %{ name: %{ first: "C. J.", last: "Cherryh" }, book: "Rimrunners" },
  %{ name: %{ first: "Malka", last: "Older" }, book: "Infomocracy" },
  %{ name: %{ first: "Sherri S.", last: "Tepper" }, book: "Grass" },
  %{ name: %{ first: "Laura J.", last: "Mixon" }, book: "Glass Houses" },
  %{ name: %{ first: "L. X.", last: "Beckett" }, book: "Gamechanger" },
  %{ name: %{ first: "Ann", last: "Leckie" }, book: "Ancillary Justice" },
  %{ name: %{ first: "Pat", last: "Cadigan" }, book: "Synners" },
  %{ name: %{ first: "Becky", last: "Chambers" }, book: "The Long Way to a Small, Angry Planet" },
  %{ name: %{ first: "Martha", last: "Wells" }, book: "All Systems Red" },
  %{ name: %{ first: "Suzanne", last: "Palmer" }, book: "Finder" },
  %{ name: %{ first: "Sue", last: "Burke" }, book: "Semiosis" },
  %{ name: %{ first: "Meg", last: "Howrey" }, book: "The Wanderers" },
  %{ name: %{ first: "N. K.", last: "Jemisin" }, book: "The Fifth Season" },
  %{ name: %{ first: "C. M.", last: "Waggoner" }, book: "Unnatural Magic" },
  %{ name: %{ first: "Naomi", last: "Novik" }, book: "Spinning Silver" }
]

letter_in_name = fn (:get, collection, next_fn) ->
  for row <- collection do
    if contains?(downcase(row.name.first), "a") do
      next_fn.(row)
    end
  end
end

IO.inspect get_in(authors, [ letter_in_name, :book ])
IO.inspect get_in(authors, [ Access.all(), :name, :last ])
IO.inspect get_in(authors, [ Access.at(1), :book ])
IO.inspect get_and_update_in(authors, [Access.all(), :name, :last],
  fn (val) -> {val, upcase(val)} end)
