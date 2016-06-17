# Exercise: ModulesAndFunctions-1
Extend the *Times* module with a *triple* function that multiplies its parameter by three.

## Solution
See the [Times.exs](../times.exs) file. Since exercises 1-3 all use this file, it has been placed in the parent directory.

We added the function definition:
```
def triple(n), do: n * 3  
```

Let's run it in *iex*:
```
iex> Times.triple 5
15
```
