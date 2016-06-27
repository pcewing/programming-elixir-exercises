#Exercise: WorkingWithMultipleProcesses-2
Write a program that spawns two processes and then passes each a unique token (for example, "fred" and "betty"). Have them send the tokens back.
- Is the order in which the replies are received deterministic in theory? In practice?
- If either answer is no, how could you make it so?

## Solution
See the [processes.exs](./processes.exs) file for the full module.

In theory, the order should not be deterministic. Whichever process finishes first may respond first. In practice, it appears that the first process to be sent a message is also the first process to respond. Several executions indicated this.

If we wanted to be sure that one responded before the other, we could send a message to both child processes, but have the second child process also expect a message from the first. The first child process could respond to the parent as well as send a message to the second, and when the second process has received a message from the parent and the first child, it could then respond.
