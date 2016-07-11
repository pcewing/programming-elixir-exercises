# Exercise: MacrosAndCodeEvaluation-1
Write a macro called *myunless* that implements the standard *unless* functionality. You're allowed to use the regular *if* expression in it.

## Solution
See the [my.exs](./my.exs) file for the full module.

This is almost a direct copy of the *if* macro so I won't bother describing the implementation. Testing the module in *iex*:
```
iex> require My
nil
iex> My.unless 1 == 2 do IO.puts "1 != 2" else IO.puts "1 == 2" end
1 != 2
:ok
iex> My.unless 1 == 1 do IO.puts "1 != 1" else IO.puts "1 == 1" end
1 == 1
:ok
```
