# Exercise: OTP-Supervisors-2
Rework your stack server to use a supervision tree with a separate stash process to hold that state. Verify that it works and that when you crash the server the state is retained across a restart.

## Solution
See the [stack](./stack) directory for the full project.

It is a little hard to tell if the state is preserved when we cause an error by popping an empty stack. So, I changed the *push* implementation to the following so we could observe a couple scenarios:
```
def handle_cast({:push, item}, {current_stack, stash_pid} = state) do
  case item do
    1 ->
      raise RuntimeError
    2 ->
      {:stop, :normal, state}
    _ ->
      {:noreply, {[item | current_stack], stash_pid}}
  end
end
```

If *1* is pushed onto the stack, we will raise a *RuntimeError*. If *2* is pushed, we will stop the server normally; let's see if it restarts:

First let's try the case where we pop from an empty stack:
```
iex> Stack.Server.pop
1
iex> Stack.Server.pop
2
iex> Stack.Server.pop
3
iex> Stack.Server.pop
Stack.Server.terminate - Reason: {{:badmatch, []}, [{Stack.Server, :handle_call, 3, [file: 'lib/stack/server.ex', line: 39]}, {:gen_server, :try_handle_call, 4, [file: 'gen_server.erl', line: 615]}, {:gen_server, :handle_msg, 5, [file: 'gen_server.erl', line: 647]}, {:proc_lib, :init_p_do_apply, 3, [file: 'proc_lib.erl', line: 247]}]}; State: {[], #PID<0.126.0>}
** (exit) exited in: GenServer.call(MyStack, :pop, 5000)
    ** (EXIT) an exception was raised:
        ** (MatchError) no match of right hand side value: []
            (stack) lib/stack/server.ex:39: Stack.Server.handle_call/3
            (stdlib) gen_server.erl:615: :gen_server.try_handle_call/4
            (stdlib) gen_server.erl:647: :gen_server.handle_msg/5
            (stdlib) proc_lib.erl:247: :proc_lib.init_p_do_apply/3

09:03:20.456 [error] GenServer MyStack terminating
** (MatchError) no match of right hand side value: []
    (stack) lib/stack/server.ex:39: Stack.Server.handle_call/3
    (stdlib) gen_server.erl:615: :gen_server.try_handle_call/4
    (stdlib) gen_server.erl:647: :gen_server.handle_msg/5
    (stdlib) proc_lib.erl:247: :proc_lib.init_p_do_apply/3
Last message: :pop
State: {[], #PID<0.126.0>}
    (elixir) lib/gen_server.ex:564: GenServer.call/3
iex> Stack.Server.pop
Stack.Server.terminate - Reason: {{:badmatch, []}, [{Stack.Server, :handle_call, 3, [file: 'lib/stack/server.ex', line: 39]}, {:gen_server, :try_handle_call, 4, [file: 'gen_server.erl', line: 615]}, {:gen_server, :handle_msg, 5, [file: 'gen_server.erl', line: 647]}, {:proc_lib, :init_p_do_apply, 3, [file: 'proc_lib.erl', line: 247]}]}; State: {[], #PID<0.126.0>}
** (exit) exited in: GenServer.call(MyStack, :pop, 5000)
    ** (EXIT) an exception was raised:
        ** (MatchError) no match of right hand side value: []
            (stack) lib/stack/server.ex:39: Stack.Server.handle_call/3
            (stdlib) gen_server.erl:615: :gen_server.try_handle_call/4
            (stdlib) gen_server.erl:647: :gen_server.handle_msg/5
            (stdlib) proc_lib.erl:247: :proc_lib.init_p_do_apply/3

09:03:23.443 [error] GenServer MyStack terminating
** (MatchError) no match of right hand side value: []
    (stack) lib/stack/server.ex:39: Stack.Server.handle_call/3
    (stdlib) gen_server.erl:615: :gen_server.try_handle_call/4
    (stdlib) gen_server.erl:647: :gen_server.handle_msg/5
    (stdlib) proc_lib.erl:247: :proc_lib.init_p_do_apply/3
Last message: :pop
State: {[], #PID<0.126.0>}
    (elixir) lib/gen_server.ex:564: GenServer.call/3
```
The stack server was restarted and the stack was still empty, so popping again caused it to fail again. Previously, the stack would have been restarted with its initial state *[1, 2, 3]*.

Now let's try causing an error by pushing *1*:
```
iex> Stack.Server.push 3
:ok
iex> Stack.Server.push 4
:ok
iex> Stack.Server.pop  
4
iex> Stack.Server.push 1
:ok
iex> Stack.Server.terminate - Reason: {%RuntimeError{message: "runtime error"}, [{Stack.Server, :handle_cast, 2, [file: 'lib/stack/server.ex', line: 30]}, {:gen_server, :try_dispatch, 4, [file: 'gen_server.erl', line: 601]}, {:gen_server, :handle_msg, 5, [file: 'gen_server.erl', line: 667]}, {:proc_lib, :init_p_do_apply, 3, [file: 'proc_lib.erl', line: 247]}]}; State: {[3], #PID<0.126.0>}

09:04:05.751 [error] GenServer MyStack terminating
** (RuntimeError) runtime error
    (stack) lib/stack/server.ex:30: Stack.Server.handle_cast/2
    (stdlib) gen_server.erl:601: :gen_server.try_dispatch/4
    (stdlib) gen_server.erl:667: :gen_server.handle_msg/5
    (stdlib) proc_lib.erl:247: :proc_lib.init_p_do_apply/3
Last message: {:"$gen_cast", {:push, 1}}
State: {[3], #PID<0.126.0>}
iex> Stack.Server.pop   
3
```
Even after the stack terminates and restarts, the next number we pop is 3, which is the last successful push (That wasn't popped) before the server died.

Lastly, let's try *stopping* the server to see it the supervisor restarts it:
```
iex> Stack.Server.push 2
:ok
iex> Stack.Server.terminate - Reason: :normal; State: {[1, 2, 3], #PID<0.113.0>}

nil
iex> Stack.Server.pop
1
```
So, when the server is *stopped* with the reason *:normal*, the supervisor still restarts it!
