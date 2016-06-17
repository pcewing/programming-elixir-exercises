# Exercise: ModulesAndFunctions-4
Implement and run a function *sum(n)* that uses recursion to calculate the sum of the integers from 1 to *n*. You'll need to write this function inside a module in a separate file. Then load up *iex*, compile that file, and try your function.

## Solution
See the [sum.exs](./sum.exs) file for the full module.

There are only two necessary cases; however we will implement three.

The base case:
```
defp do_calculate(0), do: 0  
```

A second base case:
```
defp do_calculate(1), do: 1  
```

And the main case:
```
defp do_calculate(n), do: n + do_calculate(n - 1)  
```

The second base case is not actually necessary but adding 0 to the sum has no effect so this simply prevents us from doing that.

Lastly, add a non-private function with a guard clause to prevent invalid parameters and presto:
```
iex> Sum.calculate 3
6
iex> Sum.calculate 5
15
iex> Sum.calculate -4
{:error, "Expected a positive integer."}
```
