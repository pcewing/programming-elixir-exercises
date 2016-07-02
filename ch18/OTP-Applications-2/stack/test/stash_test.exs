defmodule StashTest do
  use ExUnit.Case

  test "get retrieves the value from the stash" do
    {:ok, pid} = Stack.Stash.start_link([1, 2, 3])

    stack = Stack.Stash.get(pid)
    assert stack == [1, 2, 3]
  end

  test "set stores a value in the stash" do
    {:ok, pid} = Stack.Stash.start_link([])

    Stack.Stash.set(pid, [1, 2, 3])

    stack = Stack.Stash.get(pid)
    assert stack == [1, 2, 3]
  end
end
