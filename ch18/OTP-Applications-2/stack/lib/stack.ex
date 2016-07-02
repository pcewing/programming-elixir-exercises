defmodule Stack do
  use Application

  def start(_type, _args) do
    {:ok, _pid} = Stack.StashSupervisor.start_link([1, 2, 3])
  end
end
