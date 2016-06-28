#Exercise: WorkingWithMultipleProcesses-8
Run the Fibonacci code on your machine. Do you get comparable timings? If your machine has multiple cores and/or processors, do you see improvements in the timing as we increase the application's concurrency?

## Solution
See the [fibonacci.exs](./fibonacci.exs) file for the full modules.

So, I see no performance increase whatsoever:
```
iex> Runner.run
[{37, 24157817}, {37, 24157817}, {37, 24157817}, {37, 24157817}, {37, 24157817}, {37, 24157817}]

 #   time (s)
 1     5.90
 2     5.85
 3     5.86
 4     5.91
 5     5.97
 6     5.87
 7     5.86
 8     5.90
 9     5.86
10     5.84
:ok
```

I'm on a multi-core machine; however, I'm running this in a VM that is only allocated 1 processor. Maybe when I'm at home I'll try running this again. I would expect the results to be more in line with those in the book.

I'm a little confused why the results in the book show: `{37, 39088169}`; *fib(37)* should equal 24,157,817. Oh well.
