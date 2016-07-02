defmodule Sequence do
  use Application

  def start(_type, _args) do
    #{:ok, _pid} = Sequence.Supervisor.start_link({123, 1})
    {:ok, _pid} = Sequence.Supervisor.start_link(123)
  end
end
