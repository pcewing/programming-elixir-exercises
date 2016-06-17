# Exercise: Functions-4
Write a function *prefix* that takes a string. It should return a new function that takes a second string. When that second function is called, it will return a string containing the first string, a space, and the second string.

## Solution

First things first, we know the function needs to take a string as a parameter and return a function that also takes a string as a parameter:
```
func = fn str_a ->
  fn str_b ->
    # TODO
  end
end
```

Cool, now let's add the functionality to the inner-function.
```
func = fn str_a ->
  fn str_b ->
    "#{str_a} #{str_b}"
  end
end
```

It should be functional, but let's name things more intuitively now that we know what it's purpose is.
```
prefix = fn prefix_string ->
  fn postfix_string ->
    "#{prefix_string} #{postfix_string}"
  end
end
```

And let's test it out!
```
iex> prefix = fn prefix_string ->
...>   fn postfix_string ->
...>     "#{prefix_string} #{postfix_string}"
...>   end
...> end
#Function<6.50752066/1 in :erl_eval.expr/5>
iex> mrs = prefix.("Mrs")
#Function<6.50752066/1 in :erl_eval.expr/5>
iex> mrs.("Smith")
"Mrs Smith"
```

Magnificent.
