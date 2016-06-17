# Exercise: ModulesAndFunctions-3
Add a *quadruple* function. (Maybe it could call the *double* function...)

## Solution
See the [Times.exs](../times.exs) file.

We added the function definition:
```
def quadruple(n), do: n |> double |> double
```

It calls *double* for the sake of using another function within the module; however, realistically it would be simpler to define it as:
```
def quadruple(n), do: n * 4
```

Let's run it:
```
iex> Times.quadruple 5
20
```
