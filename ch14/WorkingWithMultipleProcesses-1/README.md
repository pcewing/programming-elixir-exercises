# Exercise: WorkingWithMultipleProcesses-1
Run this code on your machine; see if you get comparable results.

## Solution
See the [chain.exs](./chain.exs) file for the full module.

I saw similar behavior up until the run with 1,000,000 processes. It may be related to running this within a VM but running the million processes actually froze the VM for some time before it finished. Oddly enough, the run with 400,000 processes was actually considerably faster on my machine than documented in the book. This aligns with the execution times of the previous runs as well so It shall remain a mystery why the million processes tanked my system.
```
$ elixir -r chain.exs -e "Chain.run(10)"
{3154, "Result is 10"}
$ elixir -r chain.exs -e "Chain.run(100)"
{2259, "Result is 100"}
$ elixir -r chain.exs -e "Chain.run(1000)"
{2817, "Result is 1000"}
$ elixir -r chain.exs -e "Chain.run(10000)"
{9461, "Result is 10000"}
$ elixir --erl "+P 1000000" -r chain.exs -e "Chain.run(400_000)"
{1156269, "Result is 400000"}
$ elixir --erl "+P 1000000" -r chain.exs -e "Chain.run(1_000_000)"
{54507489, "Result is 1000000"}
```
