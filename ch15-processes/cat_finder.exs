defmodule Scheduler do
  def run(num_processes, module, func, files) do
    (1..num_processes)
    |> Enum.map(fn(_) -> spawn(module, func, [self()]) end)
    |> schedule_processes(files, [])
  end

  defp schedule_processes(processes, queue, results) do
    receive do
      {:ready, pid} when queue != [] ->
        [next | tail] = queue
        send(pid, {:cat, next, self()})
        schedule_processes(processes, tail, results)

      {:ready, pid} ->
        send(pid, {:shutdown})
        if length(processes) > 1 do
          schedule_processes(List.delete(processes, pid), queue, results)
        else
          Enum.sort(results, fn {n1,_}, {n2,_} -> n1 <= n2 end)
        end
      {:answer, filename, result, _pid} ->
        schedule_processes(processes, queue, [{filename, result} | results])
    end
  end
end

defmodule CatFinder do
  def cat(scheduler) do
    send(scheduler, {:ready, self()})
    receive do
      {:cat, file, client} ->
        send(client, {:answer, Path.basename(file), find_cat(file), self()})
        cat(scheduler)
      {:shutdown} ->
        exit(:normal)
    end
  end

  defp find_cat(file) do
    file
    |> File.read!
    |> String.count("cat")
  end
end

directory = "/Users/nickstevens/Desktop/Cheat Sheets/"

files_to_process = 
  directory
  |> File.ls!()
  |> Enum.map(&Path.join(directory, &1))
  |> Enum.filter(&File.regular?/1)      # keep only real files

num_processes = length(files_to_process)

results = Scheduler.run(num_processes, CatFinder, :cat, files_to_process)

IO.inspect(results)

total = Enum.reduce(results, 0, fn {_filename, result}, acc -> result + acc end)

IO.puts("String 'cat' found #{total} times in directory.")
  
