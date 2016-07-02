defmodule Sequence.Server do
  use GenServer
  require Logger

  defmodule State, do: defstruct current_number: 0, stash_pid: nil, delta: 1

  @vsn "2"

  #####
  # External API

  def start_link(stash_pid) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, stash_pid, name: __MODULE__)
  end

  def next_number do
    GenServer.call(__MODULE__, :next_number)
  end

  def increment_number(delta) do
    GenServer.cast(__MODULE__, {:increment_number, delta})
  end

  #####
  # GenServer implementation

  def init(stash_pid) do
    %{current_number: current_number, delta: delta} = Sequence.Stash.get_value(stash_pid)
    {:ok, %State{current_number: current_number, stash_pid: stash_pid, delta: delta}}
  end

  def handle_call(:next_number, _from, state) do
    {
      :reply,
      state.current_number,
      %{state | current_number: state.current_number + state.delta}
    }
  end

  def handle_cast({:increment_number, delta}, state) do
    {
      :noreply,
      %{state | current_number: state.current_number + delta, delta: delta}
    }
  end

  def terminate(_reason, state) do
    value = %{current_number: state.current_number, delta: state.delta}
    Sequence.Stash.save_value(state.stash_pid, value)
  end

def code_change("1", old_state = %{current_number: current_number, stash_pid: stash_pid, delta: delta}, _extra) do
  new_state = %State{current_number: current_number, stash_pid: stash_pid, delta: delta}
  Sequence.Stash.save_value(stash_pid, {current_number, delta})
  Logger.info "Changing code from 1 to 2"
  Logger.info inspect(old_state)
  Logger.info inspect(new_state)
  {:ok, new_state}
end
end
