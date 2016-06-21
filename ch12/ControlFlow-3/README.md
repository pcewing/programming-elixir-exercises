# Exercise: ControlFlow-3
Many built-in functions have two forms. The *xxx* form returns the tuple *{:ok, data}* and the *xxx!* form returns data on success but raises an exception otherwise. However, some functions don't have the *xxx!* form.

Write an *ok!* function that takes an arbitrary parameter. If the parameter is the tuple *{:ok, data}*, return the data. Otherwise, raise an exception containing information from the parameter.

You could use your function like this:
```
file = ok! File.open("somefile")
```

## Solution
I'm not going to bother putting this in a module. Let's just do this with an anonymous function. It can use pattern matching to identify whether or not *{:ok, data}* was passed in.
```
ok! = fn
  {:ok, data} -> data
  _ -> raise RuntimeError
end
```

In *iex*:
```
$ touch exists.txt
$ iex
iex> ok! = fn
...>   {:ok, data} -> data
...>   _ -> raise RuntimeError
...> end
#Function<6.50752066/1 in :erl_eval.expr/5>
iex> ok!.(File.open("exists.txt"))
#PID<0.64.0>
iex> ok!.(File.open("doesnt_exist.txt"))
** (RuntimeError) runtime error
```
