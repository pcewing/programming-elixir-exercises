# Exercise: OTP-Servers-3
Give your stack server process a name, and make sure it is accessible by that name in *iex*.

## Solution
See the [stack](./stack) directory for the full project.

```
iex> Stack.Server.start_link([1, 2, 3])
{:ok, #PID<0.112.0>}
iex> GenServer.call(MyStack, :pop)
1
```
