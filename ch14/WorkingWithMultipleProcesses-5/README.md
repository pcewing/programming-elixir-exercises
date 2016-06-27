#Exercise: WorkingWithMultipleProcesses-5
Repeat the two, changing *spawn_link* to *spawn_monitor*.

## Solution
See the [processes_no_ex.exs](./processes_no_ex.exs) and [processes_ex.exs](./processes_ex.exs) files for the full modules.

When running the implementation where the child does not raise an exception, we now see the *DOWN* message.
```
iex> ProcessesNoEx.run
Message: "Hello!"
Message: {:DOWN, #Reference<0.0.1.133>, :process, #PID<0.88.0>, :normal}
All messages received.
:ok
```

When running the version where the child does throw, we see the child die; however, the parent stays alive and wakes up to receive the message the child sent as well as the *DOWN* message containing the error.
```
iex> ProcessesEx.run

13:05:13.090 [error] Process #PID<0.88.0> raised an exception
** (RuntimeError) runtime error
    processes_ex.exs:21: ProcessesEx.child/1
Message: "Hello!"
Message: {:DOWN, #Reference<0.0.1.134>, :process, #PID<0.88.0>, {%RuntimeError{message: "runtime error"}, [{ProcessesEx, :child, 1, [file: 'processes_ex.exs', line: 21]}]}}
All messages received.
:ok
```
