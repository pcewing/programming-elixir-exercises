defmodule Stack.Stash do
  use GenServer

  def get(pid) do
    GenServer.call(pid, :get)
  end

  def set(pid, stack) do
    GenServer.cast(pid, {:set, stack})
  end

  ###
  # GenServer API
  ###

  def start_link(initial_stack) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, initial_stack)
  end

  def handle_call(:get, _from, current) do
    {:reply, current, current}
  end

  def handle_cast({:set, new}, _current) do
    {:noreply, new}
  end
end
