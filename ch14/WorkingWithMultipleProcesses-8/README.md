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

### At Home
So, the previous run was on my work computer but I tried the same thing again at home and saw interesting results:
```
iex> Runner.run
[{37, 24157817}, {37, 24157817}, {37, 24157817}, {37, 24157817}, {37, 24157817}, {37, 24157817}]

 #   time (s)
 1     7.90
 2     4.11
 3     2.76
 4     2.72
 5     2.90
 6     1.93
 7     1.91
 8     1.95
 9     1.93
10     1.91
:ok
```

The single processor run was actually slower; however, adding processes significantly increased the performance. My home PC is running an i7 2600k, which has 4 cores and 8 threads, so it makes sense that there were performance gains. I'm unsure of why it levels off between 3 and 6 and then at 7 instead of 8 but regardless, it's pretty cool to see the power of concurrency. From 7.9 down to ~1.9 seconds is a pretty awesome increase.
