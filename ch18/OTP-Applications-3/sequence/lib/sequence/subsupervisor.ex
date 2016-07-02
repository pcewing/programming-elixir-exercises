defmodule Sequence.SubSupervisor do
  use Supervisor

  def start_link(stash_pid) do
    {:ok, _pid} = Supervisor.start_link(__MODULE__, stash_pid)
  end
  def init(stash_pid) do
    child_processes = [worker(Sequence.Server, [stash_pid])]
    supervise(child_processes, strategy: :one_for_one)
  end
end
