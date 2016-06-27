defmodule Processes do
  def run do
    betty = spawn(Processes, :betty, [])
    fred = spawn(Processes, :fred, [])

    send betty, {self, "betty"}
    send fred, {self, "fred"}

    receive do
      {_sender, "betty"} -> IO.puts "Betty replied first!"
      {_sender, "fred"} -> IO.puts "Fred replied first!"
    end

    receive do
      {_sender, "betty"} -> IO.puts "Betty replied second!"
      {_sender, "fred"} -> IO.puts "Fred replied second!"
    end
  end

  def betty do
    receive do
      {sender, "betty"} -> send sender, {self, "betty"}
    end
  end

  def fred do
    receive do
      {sender, "fred"} -> send sender, {self, "fred"}
    end
  end
end
