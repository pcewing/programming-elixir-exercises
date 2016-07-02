# Exercise: OTP-Applications-2
So far, we haven't written any tests for the application. Is there anything you can test? See what you can do.

## Solution
See the [stack](./stack) directory for the full project.

First we can add some tests for the *Stash* module to make sure setting and getting the value in the stash works:
```
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
```

A *Stash* process will actually be started automatically by the application but because we didn't name it we don't know its PID. So, we can just create a new one in the tests to use.

Then we can add a couple tests to gain confidence that pushing and popping work:
```
defmodule ServerTest do
  use ExUnit.Case

  test "popping retrieves an item from the stack" do
    top = Stack.Server.pop
    assert top == 1
  end

  test "pushing adds an item to the stack" do
    Stack.Server.push(25)
    top = Stack.Server.pop
    assert top == 25
  end
end
```

Running *mix test*:
```
$ mix test
.....

Finished in 0.03 seconds (0.03s on load, 0.00s on tests)
5 tests, 0 failures

Randomized with seed 389487
```

Obviously this is a pretty weak set of tests but it's better than what we had.
