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
    {:noreply, [item | state]}
  end

  def handle_call(:pop, _from, state) do
    [item | tail] = state
    {:reply, item, tail}
  end
end
