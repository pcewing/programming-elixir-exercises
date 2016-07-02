# Exercise: Functions-3
The operator *rem(a, b)* returns the remainder after dividing *a* by *b*. Write a function that takes a single integer (*n*) and calls the function in the previous exercise, passing it *rem(n, 3)*, *rem(n, 5)*, and *n*. Call it seven times with the arguments 10, 11, 12, and so on. You should get "Buzz, 11, Fizz, 13, 14, FizzBuzz, 16".

## Solution

Recall the function we wrote in the previous exercise:
```
fizz_buzz = fn  
  0, 0, c -> "FizzBuzz"  
  0, b, c -> "Fizz"  
  a, 0, c -> "Buzz"  
  a, b, c -> c  
end  
```

Let's rename it since it isn't actually the complete FizzBuzz solution:
```
fizz_buzz_helper = fn  
  0, 0, c -> "FizzBuzz"  
  0, b, c -> "Fizz"  
  a, 0, c -> "Buzz"  
  a, b, c -> c  
end  
```

Then our solution to this problem will look like:
```
fizz_buzz = fn n -> fizz_buzz_helper.(rem(n, 3), rem(n,5), n) end
```

Let's call it seven times and check.
```
10..16 |> Enum.to_list |> Enum.map(fn(n) -> fizz_buzz.(n) end)
```

Put it all together in *iex* and we see:
```
iex> fizz_buzz_helper = fn  
...>   0, 0, c -> "FizzBuzz"  
...>   0, b, c -> "Fizz"  
...>   a, 0, c -> "Buzz"  
...>   a, b, c -> c  
...> end  
#Function<18.50752066/3 in :erl_eval.expr/5>  
iex> fizz_buzz = fn n -> fizz_buzz_helper.(rem(n, 3), rem(n,5), n) end  
#Function<6.50752066/1 in :erl_eval.expr/5>  
iex> 10..16 |> Enum.to_list |> Enum.map(fn(n) -> fizz_buzz.(n) end)  
["Buzz", 11, "Fizz", 13, 14, "FizzBuzz", 16]  
```
