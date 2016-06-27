defmodule Processes do
  def run do
    spawn_link(Processes, :child, [self])

    :timer.sleep(500)

    loop_receive
  end

  def loop_receive do
    receive do
      message ->
        IO.puts "Message: #{message}"
        loop_receive
    after 500 -> IO.puts "All messages received."
    end
  end

  def child(parent) do
    send parent, "Hello!"
  end
end
