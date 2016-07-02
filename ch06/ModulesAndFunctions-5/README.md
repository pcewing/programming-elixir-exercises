# Exercise: ModulesAndFunctions-5
Write a function *gcd(x, y)* that finds the greatest common divisor between two nonnegative integers. Algebraically, *gcd(x, y)* is *x* if *y* is zero; it's *gcd(y, rem(x, y))* otherwise.

## Solution
See the [gcd.exs](./gcd.exs) file for the full module.

I'm not going to discuss the public function definitions since guard clauses aren't actually covered until the next section, but for the private functions that do the actual work, there are only two cases as described in the problem.

Case 1:
```
defp do_calculate(x, 0), do: x  
```

Case 2:
```
defp do_calculate(x, y), do: do_calculate(y, rem(x, y))  
```

Let's test it out:
```
iex> GCD.calculate(4, 12)
4
iex> GCD.calculate(36, 48)
12
```

Dope.
