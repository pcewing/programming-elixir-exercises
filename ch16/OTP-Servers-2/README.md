# Exercise: OTP-Servers-2
Extend your stack server with a *push* interface that adds a single value to the top of the stack. This will be implemented as a cast.

Experiment in *iex* with pushing and popping values.

## Solution
See the [stack](./stack) directory for the full project.

```
iex> {:ok, pid} = GenServer.start_link(Stack.Server, [])
{:ok, #PID<0.112.0>}
iex> GenServer.cast(pid, {:push, 1})
:ok
iex> GenServer.cast(pid, {:push, 2})
:ok
iex> GenServer.call(pid, :pop)
2
iex> GenServer.call(pid, :pop)
1
```
