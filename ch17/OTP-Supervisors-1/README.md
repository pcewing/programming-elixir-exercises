# Exercise: OTP-Supervisors-1
Add a supervisor to your stack application. Use *iex* to make sure it starts the server correctly. Use the server normally, and then crash it (try popping from an empty stack). Did it restart? What were the stack contents after the restart?

## Solution
See the [stack](./stack) directory for the full project.

The server restarted when fourth pop was called. When the supervisor restarted it, it was restarted with the same parameters as the first time, so the first pop return the integer 1.
```
iex> Stack.Server.pop
1
iex> Stack.Server.pop
2
iex> Stack.Server.pop
3
iex> Stack.Server.pop
Reason: {{:badmatch, []}, [{Stack.Server, :handle_call, 3, [file: 'lib/stack/server.ex', line: 35]}, {:gen_server, :try_handle_call, 4, [file: 'gen_server.erl', line: 615]}, {:gen_server, :handle_msg, 5, [file: 'gen_server.erl', line: 647]}, {:proc_lib, :init_p_do_apply, 3, [file: 'proc_lib.erl', line: 247]}]}; State: []
** (exit) exited in: GenServer.call(MyStack, :pop, 5000)
    ** (EXIT) an exception was raised:
        ** (MatchError) no match of right hand side value: []
            (stack) lib/stack/server.ex:35: Stack.Server.handle_call/3
            (stdlib) gen_server.erl:615: :gen_server.try_handle_call/4
            (stdlib) gen_server.erl:647: :gen_server.handle_msg/5
            (stdlib) proc_lib.erl:247: :proc_lib.init_p_do_apply/3

22:10:13.662 [error] GenServer MyStack terminating
** (MatchError) no match of right hand side value: []
    (stack) lib/stack/server.ex:35: Stack.Server.handle_call/3
    (stdlib) gen_server.erl:615: :gen_server.try_handle_call/4
    (stdlib) gen_server.erl:647: :gen_server.handle_msg/5
    (stdlib) proc_lib.erl:247: :proc_lib.init_p_do_apply/3
Last message: :pop
State: []
    (elixir) lib/gen_server.ex:564: GenServer.call/3
iex> Stack.Server.pop
1
```
