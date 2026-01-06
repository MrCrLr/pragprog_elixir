defmodule Scheduler do
  def run(num_processes, work_func, items) when is_function(work_func, 1) do
    (1..num_processes)
    |> Enum.map(fn(_) -> spawn(__MODULE__, :worker, [self(), work_func]) end)
    |> schedule_processes(items, [])
  end

  def worker(scheduler, work_func) do
    send(scheduler, {:ready, self()})
    
    receive do
      {:work, item, client} ->
        result = work_func.(item)
        send(client, {:answer, item, result, self()})
        worker(scheduler, work_func)

      {:shutdown} ->
        exit(:normal)
    end
  end

  defp schedule_processes(processes, q, results) do
    receive do
      {:ready, pid} -> 
        case q do
          [next | tail] ->
            send(pid, {:work, next, self()})
            schedule_processes(processes, tail, results)

          [ ] ->
            shutdown(pid, processes, results)
        end

      {:answer, item, result, _pid} ->
        schedule_processes(processes, q, [{item, result} | results])
    end
  end

  defp shutdown(pid, processes, results) do
    send(pid, {:shutdown})

    case processes do
      [_last] -> 
        Enum.sort_by(results, fn {item, _} -> item end)

      _ ->
        schedule_processes(List.delete(processes, pid), [], results)
    end
  end
end

defmodule CatFinder do
  def find_cat(file) do
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

file_count = length(files_to_process)
func = &CatFinder.find_cat/1
max_processes = 20

Enum.each(1..max_processes, fn processes ->
  {time, results} = 
      :timer.tc(Scheduler, :run, [processes, func, files_to_process])

  if processes == 1 do
    IO.inspect(Enum.map(results, fn {f, c} -> 
        {Path.basename(f), c} end))  
    
    total = Enum.reduce(results, 0, fn {_, c}, acc -> c + acc end)

    IO.puts("""
    String 'cat' found #{total} times 
    in #{directory} 
    containing #{file_count} files.
    """)

    IO.puts("\n# workers  time (seconds)")
  end

  :io.format("  ~2B        ~.6f~n", [processes, time / 1_000_000.0])
end)

