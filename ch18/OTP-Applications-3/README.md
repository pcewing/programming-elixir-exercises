# Exercise: OTP-Applications-3
Our boss notices that after we applied our version-0-to-version-1 code change, the delta indeed works as specified. However, she also notices that if the server crashes, the delta is forgotten -- only the current number is retained. Write a new update that stashes both values.

## Solution
See the [sequence](./sequence) directory for the full project.

So, to accomplish this, we're not actually changing the sequence server's state struct at all. There are really only three necessary code changes. We want to store the delta when we terminate:
```
def terminate(_reason, state) do
  Sequence.Stash.save_value(state.stash_pid, {state.current_number, state.delta})
end
```

And we want to load the delta when we start:
```
def init(stash_pid) do
  {current_number, delta} = Sequence.Stash.get_value(stash_pid)
  {:ok, %State{current_number: current_number, stash_pid: stash_pid, delta: delta}}
end
```

Lastly, for future runs, we will need to initialize the *Stash* with a delta of 1:
```
def start(_type, _args) do
  {:ok, _pid} = Sequence.Supervisor.start_link({123, 1})
end
```

I'm not sure if this is necessary, but the *code_change* function just needs to set the new state using the values from the old state:
```
def code_change("1", old_state = %{current_number: current_number, stash_pid: stash_pid, delta: delta}, _extra) do
  new_state = %State{current_number: current_number, stash_pid: stash_pid, delta: delta}
  Sequence.Stash.save_value(stash_pid, {current_number, delta})
  Logger.info "Changing code from 1 to 2"
  Logger.info inspect(old_state)
  Logger.info inspect(new_state)
  {:ok, new_state}
end
```

I wanted to be explicit, but we could probably just write it like:
```
def code_change("1", old_state, _extra) do
  new_state = old_state
  Sequence.Stash.save_value(stash_pid, {new_state.current_number, new_state.delta})
  Logger.info "Changing code from 1 to 2"
  Logger.info inspect(old_state)
  Logger.info inspect(new_state)
  {:ok, new_state}
end
```

Everything's looking good; let's see if after we apply the code change it maintains the delta across crashes:
```
iex> Sequence.Server.next_number
123
iex> Sequence.Server.next_number
124
iex> Sequence.Server.increment_number(5)
:ok
iex> Sequence.Server.next_number        
130
iex> :sys.suspend(Sequence.Server)
:ok
iex> c("new_server.ex")
new_server.ex:1: warning: redefining module Sequence.Server
new_server.ex:5: warning: redefining module Sequence.Server.State
[Sequence.Server, Sequence.Server.State]
iex> :sys.change_code(Sequence.Server, Sequence.Server, "1", [])

11:00:34.235 [info]  Changing code from 1 to 2

11:00:34.238 [info]  %Sequence.Server.State{current_number: 135, delta: 5, stash_pid: #PID<0.136.0>}

11:00:34.238 [info]  %Sequence.Server.State{current_number: 135, delta: 5, stash_pid: #PID<0.136.0>}
:ok
iex> :sys.resume(Sequence.Server)
:ok
iex> Sequence.Server.next_number
135
iex> Sequence.Server.increment_number("abc")
:ok
iex>
11:01:14.052 [error] GenServer Sequence.Server terminating
** (ArithmeticError) bad argument in arithmetic expression
    (sequence) new_server.ex:43: Sequence.Server.handle_cast/2
    (stdlib) gen_server.erl:601: :gen_server.try_dispatch/4
    (stdlib) gen_server.erl:667: :gen_server.handle_msg/5
    (stdlib) proc_lib.erl:247: :proc_lib.init_p_do_apply/3
Last message: {:"$gen_cast", {:increment_number, "abc"}}
State: %Sequence.Server.State{current_number: 140, delta: 5, stash_pid: #PID<0.136.0>}

nil
iex> Sequence.Server.next_number
140
iex> Sequence.Server.next_number
145
```

Radical.
