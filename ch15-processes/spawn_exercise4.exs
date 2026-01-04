defmodule SpawnExercise4 do
  import :timer, only: [sleep: 1]

  def howdy_fun(parent_pid) do
    child_pid = self()
    send(parent_pid, {{child_pid, parent_pid}, {:ok, "Howdy Nico!"}})
    raise "kablooey"
  end

  def run do
    Process.flag(:trap_exit, true)

    parent = self()
    child  = spawn_link(__MODULE__, :howdy_fun, [parent])

    sleep(500)

    receive do
      {{^child, ^parent}, {:ok, msg}} ->
        IO.puts("""
        MESSAGE RECEIVED: #{inspect(msg)}
        PARENT: #{inspect(parent)}
        CHILD:  #{inspect(child)}
        """)
    end

    receive do
      {:EXIT, ^child, reason} ->
        IO.puts("CHILD EXITED WITH: #{inspect(reason)}")
    end
  end
end

SpawnExercise4.run

