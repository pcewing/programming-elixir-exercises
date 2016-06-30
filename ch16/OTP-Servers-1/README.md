# Exercise: OTP-Servers-1
You're going to start creating a server that implements a stack. The call that initializes your stack will pass in a list of the initial stack contents.

For now, implement only the *pop* interface. It's acceptable for your server to crash if someone tries to pop from an empty stack.

For example, if initialized with *[5,"cat",9]*, successive calls to *pop* will return *5*, *"cat"*, and *9*

## Solution
See the [stack](./stack) directory for the full project.

```
iex> {:ok, pid} = GenServer.start_link(Stack.Server, [5,"cat",9])
{:ok, #PID<0.125.0>}
iex> GenServer.call(pid, :pop)
5
iex> GenServer.call(pid, :pop)
"cat"
iex> GenServer.call(pid, :pop)
9
```
