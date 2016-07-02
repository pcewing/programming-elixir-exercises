# Exercise: OTP-Servers-5
Implement the *terminate* callback in your stack handler. Use IO.puts to report the arguments it receives.

Try various ways of terminating your server. For example, popping an empty stack will raise an exception. You might add code that calls *System.halt(n)* if the *push* handler receives a number less than 10. (This will let you generate different return codes.) Use your imagination to try different scenarios.

## Solution
See the [stack](./stack) directory for the full project.

When the server shuts down due to an error, I don't see the *terminate* method being called.
```
iex> Stack.Server.start_link([1])
{:ok, #PID<0.113.0>}
iex> Stack.Server.pop
1
iex> Stack.Server.pop
** (EXIT from #PID<0.110.0>) an exception was raised:
    ** (MatchError) no match of right hand side value: []
        (stack) lib/stack/server.ex:27: Stack.Server.handle_call/3
        (stdlib) gen_server.erl:615: :gen_server.try_handle_call/4
        (stdlib) gen_server.erl:647: :gen_server.handle_msg/5
        (stdlib) proc_lib.erl:247: :proc_lib.init_p_do_apply/3

Interactive Elixir (1.2.6) - press Ctrl+C to exit (type h() ENTER for help)
iex>
19:00:02.644 [error] GenServer MyStack terminating
** (MatchError) no match of right hand side value: []
    (stack) lib/stack/server.ex:27: Stack.Server.handle_call/3
    (stdlib) gen_server.erl:615: :gen_server.try_handle_call/4
    (stdlib) gen_server.erl:647: :gen_server.handle_msg/5
    (stdlib) proc_lib.erl:247: :proc_lib.init_p_do_apply/3
Last message: :pop
State: []
```

This piece of code was added as recommended in the problem; it will halt the system with an exit code of 0 if any integer less than 10 is pushed.
```
if is_integer(item) and item < 10 do
  System.halt(0)
end
```

Note that when it runs, *terminate* is not called, the system immediately exits.
```
iex> Stack.Server.start_link([])
{:ok, #PID<0.125.0>}
iex> Stack.Server.push(1)
```

However, I added this code as well to return a *:stop* when an integer of exactly 10 is pushed.
```
if is_integer(item) and item == 10 do
  {:stop, :normal, state}
else
  {:noreply, [item | state]}
end
```

This does trigger the *terminate* function:
```
iex> Stack.Server.start_link([])
{:ok, #PID<0.112.0>}
iex> Stack.Server.push(10)
:ok
Reason: :normal; State: []
```
