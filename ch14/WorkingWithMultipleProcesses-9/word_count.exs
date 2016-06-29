defmodule WordCounter do
  def count(scheduler) do
    send scheduler, {:ready, self}
    receive do
      {:count, file, word, client} ->
        send client, {:answer, file, word, count_word(file, word), self}
        count(scheduler)
      {:shutdown} ->
        exit(:normal)
    end
  end

  def count_word(file, word) do
    content = File.read!(file)
    tokens = String.split(content, word)
    length(tokens) - 1
  end
end

defmodule Scheduler do
  def run(num_processes, module, func, directory, word) do
    {:ok, files} = File.ls(directory)
    files = Enum.map(files, fn file -> Path.join(directory, file) end)

    (1..num_processes)
    |> Enum.map(fn(_) -> spawn(module, func, [self]) end)
    |> schedule_processes(files, word, Map.new)
  end

  defp schedule_processes(processes, queue, word, results) do
    receive do
      {:ready, pid} when length(queue) > 0 ->
        [next | tail] = queue
        send pid, {:count, next, word, self}
        schedule_processes(processes, tail, word, results)

      {:ready, pid} ->
        send pid, {:shutdown}
        if length(processes) > 1 do
          schedule_processes(List.delete(processes, pid), queue, word, results)
        else
          results
        end

      {:answer, file, _word, result, _pid} ->
        schedule_processes(processes, queue, word, Map.put(results, file, result))
    end
  end
end

defmodule Runner do
  def run do
    directory = "test_files/"
    word = "cat"

    Enum.each 1..10, fn num_processes ->
      {time, result} = :timer.tc(Scheduler, :run, [num_processes, WordCounter, :count, directory, word])

      if num_processes == 1 do
        IO.puts "\nInspecting the results:\n#{inspect result}\n\n"
        IO.puts "\n #   time (ms)"
      end
      :io.format "~2B     ~.2f~n", [num_processes, time/1000.0]
    end
  end
end
