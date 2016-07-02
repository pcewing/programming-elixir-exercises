# Exercise: OTP-Servers-4
Add the API to your stack module (the functions that wrap the GenServer calls).

## Solution
See the [stack](./stack) directory for the full project.

```
iex> Stack.Server.start_link([1, 2, 3])
{:ok, #PID<0.125.0>}
iex> Stack.Server.push("Hello")
:ok
iex> Stack.Server.pop          
"Hello"
```
