defmodule Stack.Server do
  use GenServer

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, [name: MyStack])
  end

  def handle_cast({:push, item}, state) do
    {:noreply, [item | state]}
  end

  def handle_call(:pop, _from, state) do
    [item | tail] = state
    {:reply, item, tail}
  end
end
