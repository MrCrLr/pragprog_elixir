iex(7)> :io_lib.format("~.3f", [3.14159]) |> IO.chardata_to_string()
"3.142"

iex(9)> System.get_env("SHELL")
"/bin/zsh"

iex(10)> Path.extname("elixir/test.exs")
".exs"

iex(13)> File.cwd()
{:ok, "/Users/nickstevens/Code/pragprog_elixir"}

iex(18)> json = ~s({"name": "Patricia", "age": 92})
"{\"name\": \"Patricia\", \"age\": 92}"
iex(19)> data = JSON.decode!(json)
%{"age" => 92, "name" => "Patricia"}

iex(14)> System.cmd("echo", ["pizza\nworld"])
{"pizza\nworld\n", 0}

iex(17)> System.cmd("nslookup", ["1.1.1.1"])
{"Server:\t\t10.2.0.1\nAddress:\t10.2.0.1#53\n\n
Non-authoritative answer:\n1.1.1.1.in-addr.arpa\tname = one.one.one.one.\n\n
Authoritative answers can be found from:\n\n", 0}
