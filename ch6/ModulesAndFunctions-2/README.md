# Exercise: ModulesAndFunctions-2
Run the result in *iex*. Use both techniques to compile the file.

## Solution
Launching *iex* with the filename:
```
$ iex times.exs
Erlang/OTP 18 [erts-7.3] [source-d2a6d81] [64-bit] [async-threads:10] [hipe] [kernel-poll:false]

iex> Times.triple 5
15
```

Compiling it within *iex*:
```
iex> c "times.exs"
[Times]
iex> Times.triple 5
15
```
