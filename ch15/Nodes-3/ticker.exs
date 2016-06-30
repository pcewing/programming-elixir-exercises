defmodule Ticker do
  defmodule Server do

    @interval 2000
    @name :ticker

    def start do
      pid = spawn(__MODULE__, :generator, [[], nil])
      :global.register_name(@name, pid)
    end

    def register(client_pid) do
      send :global.whereis_name(@name), { :register, client_pid }
    end

    def generator(clients, current) do
      receive do
        { :register, pid } ->
          IO.puts "registering #{inspect pid}"
          if current == nil, do: current = 0
          generator([pid | clients], current)
      after
        @interval ->
          IO.puts "tick"

          unless current == nil do
            client = Enum.at(clients, current)
            send client, { :tick }

            current =  current + 1
            if current >= length(clients), do: current = 0
          end

          generator(clients, current)
      end
    end
  end

  defmodule Client do

    def start do
      pid = spawn(__MODULE__, :receiver, [])
      Ticker.Server.register(pid)
    end

    def receiver do
      receive do
        { :tick } ->
          IO.puts "tock in client"
          receiver
      end
    end
  end
end
