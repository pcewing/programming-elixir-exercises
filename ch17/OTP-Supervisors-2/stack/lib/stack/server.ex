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

  def start_link(stash_pid) do
    GenServer.start_link(__MODULE__, stash_pid, [name: @name])
  end

  def init(stash_pid) do
    current_stack = Stack.Stash.get(stash_pid)
    {:ok, {current_stack, stash_pid}}
  end

  def handle_cast({:push, item}, {current_stack, stash_pid} = state) do
    case item do
      1 ->
        raise RuntimeError
      2 ->
        {:stop, :normal, state}
      _ ->
        {:noreply, {[item | current_stack], stash_pid}}
    end
  end

  def handle_call(:pop, _from, {current_stack, stash_pid}) do
    [item | tail] = current_stack
    {:reply, item, {tail, stash_pid}}
  end

  def terminate(reason, {current_stack, stash_pid} = state) do
    IO.puts "Stack.Server.terminate - Reason: #{inspect reason}; State: #{inspect state}"
    Stack.Stash.set(stash_pid, current_stack)
  end
end
