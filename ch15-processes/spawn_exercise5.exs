defmodule SpawnExercise5 do
  import :timer, only: [sleep: 1]

  def child(parent) do
    send(parent, {{self(), parent}, {:ok, "Howdy Nico!"}})
    exit(:boom)
  end

  def run do
    Process.flag(:trap_exit, true)

    parent = self()
    { child, ref }  = spawn_monitor(__MODULE__, :child, [parent])

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
      {:DOWN, ^ref, :process, ^child, reason} ->
        IO.puts("CHILD EXITED WITH: #{inspect(reason)}")
    end
  end
end

SpawnExercise5.run

