#Exercise: WorkingWithMultipleProcesses-4
Do the same, but have the child raise an exception. What difference do you see in the tracing?

## Solution
See the [processes.exs](./processes.exs) file for the full module.

This time it looks like the child dies and takes the parent with it. Because the child died before the parent woke up and received the message it sent, the parent never receives the message because it dies while sleeping.
```
iex> Processes.run
** (EXIT from #PID<0.86.0>) an exception was raised:
    ** (RuntimeError) runtime error
        processes.exs:21: Processes.child/1

Interactive Elixir (1.2.6) - press Ctrl+C to exit (type h() ENTER for help)
iex>
12:53:30.686 [error] Process #PID<0.90.0> raised an exception
** (RuntimeError) runtime error
    processes.exs:21: Processes.child/1
```
