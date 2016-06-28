#Exercise: WorkingWithMultipleProcesses-7
Change the *^pid* in *pmap* to *_pid*. This means the receive block will take responses in the order the processes send them. Now run the code again. Do you see any difference in the output? If you're like me, you don't, but the program clearly contains a bug. Are you scared by this? Can you find a way to reveal the problem (perhaps by passing in a different function, by sleeping, or by increasing the number of processes)? Change it back to *^pid* and make sure the order is now correct.

## Solution
See the [parallel.exs](./parallel.exs) file for the full module.

After making the change, we can see that the processes still execute in the order we want:
```
iex> Parallel.pmap [1, 2, 3], &(&1 + 1)
[2, 3, 4]
```

However, this isn't deterministic. What if the function we pass in to the *pmap* has a less consistent execution time? Let's try passing in the function below, where each execution of the function will sleep for a random amount of time between 0 and 1999 milliseconds. This is similar to how IO operations might perform. Let's try it:
```
iex> sleep_add = fn num ->
...>   milliseconds = :rand.uniform(2000)
...>   :timer.sleep(milliseconds)
...>   num + 1
...> end
#Function<6.52032458/1 in :erl_eval.expr/5>
iex> Parallel.pmap [1, 2, 3], &(sleep_add.(&1))
[3, 2, 4]
```

This time the results were obviously out of order. Let's change the *_pid* back to *^pid* but still use the *sleep_add* function and verify that the results are processed in order again:
```
iex> sleep_add = fn num ->
...>   milliseconds = :rand.uniform(2000)
...>   :timer.sleep(milliseconds)
...>   num + 1
...> end
#Function<6.52032458/1 in :erl_eval.expr/5>
iex> Parallel.pmap [1, 2, 3], &(sleep_add.(&1))
[2, 3, 4]
iex> Parallel.pmap [1, 2, 3], &(sleep_add.(&1))
[2, 3, 4]
iex> Parallel.pmap [1, 2, 3], &(sleep_add.(&1))
[2, 3, 4]
```
I ran the *pmap* a few times just to be sure we weren't getting lucky with the random milliseconds, but it looks like the results are now processed in order again!
