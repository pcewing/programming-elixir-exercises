defmodule Stack.Server do
  use GenServer

  def init(state) do
    {:ok, state}
  end

  def handle_cast({:push, item}, state) do
    {:noreply, [item | state]}
  end

  def handle_call(:pop, _from, state) do
    [item | tail] = state
    {:reply, item, tail}
  end
end
