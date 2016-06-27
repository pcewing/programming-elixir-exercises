#Exercise: WorkingWithMultipleProcesses-3
Use *spawn_link* to start a process, and have that process send a message to the parent and then exit immediately. Meanwhile, sleep for 500 ms in the parent, then receive as many messages as are waiting. Trace what you receive. Does it matter that you weren't waiting for the notification from the child when it exited?

## Solution
See the [processes.exs](./processes.exs) file for the full module.

It seems that it does matter that we weren't waiting for the message when it was sent. When executing the code:
```
iex> Processes.run
Message: Hello!
All messages received.
:ok
```

We only receive one message; on the second *receive* we timeout while waiting.
