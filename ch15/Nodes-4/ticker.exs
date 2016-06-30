defmodule Ticker do

  @interval 2000
  @leader :leader

  def register do
    case :global.whereis_name(@leader) do
      pid when is_pid(pid) ->
        send pid, { :register, self }
        follow
      :undefined ->
        :global.register_name(@leader, self)
        lead([self], nil)
    end
  end

  def lead(clients, next) do
    receive do
      { :register, pid } ->
        IO.puts "registering #{inspect pid}"
        if next == nil, do: next = 0
        lead([pid | clients], next)
    after
      @interval ->
        IO.puts "tick"

        unless next == nil do
          next_client = Enum.at(clients, next)

          next = next - 1
          if next < 0 , do: next = length(clients) - 1

          :global.unregister_name(@leader)
          send next_client, { :tick, clients, next }
          follow
        else
          lead(clients, next)
        end
    end
  end

  def follow do
    receive do
      { :tick, clients, next } ->
        IO.puts "tock in client"
        :global.register_name(@leader, self)
        lead(clients, next)
    end
  end
end
