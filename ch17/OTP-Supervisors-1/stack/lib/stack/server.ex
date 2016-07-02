defmodule Stack.Server do
  @name MyStack

  use GenServer

  def push(item) do
    GenServer.cast(@name, {:push, item})
  end

  def pop do
    GenServer.call(@name, :pop)
  end

  ###
  # GenServer API
  ###

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, [name: @name])
  end

  def handle_cast({:push, item}, state) do
    if is_integer(item) and item < 10 do
      System.halt(0)
    end

    if is_integer(item) and item == 10 do
      {:stop, :normal, state}
    else
      {:noreply, [item | state]}
    end
  end

  def handle_call(:pop, _from, state) do
    [item | tail] = state
    {:reply, item, tail}
  end

  def terminate(reason, state) do
    IO.puts "Reason: #{inspect reason}; State: #{inspect state}"
  end
end
