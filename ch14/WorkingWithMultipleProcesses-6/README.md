#Exercise: WorkingWithMultipleProcesses-6
In the *pmap* code, I assigned the value of *self* to the variable *me* at the top of the method and then used *me* as the target of the message returned by the spawned process. Why use a separate variable here?

## Solution
See the [parallel.exs](./parallel.exs) file for the full module.

Take a look at *line 6* and notice that both the variable *me* and the variable *self* are used. Why might this be?

When that function is run, it is executed on the process that is spawned and thus, when we access *self*, it is going to return the *pid* of the child process, not the parent process. So, in order to use the parent's *pid* within the context of the child thread, we need to capture it in a separate variable.
