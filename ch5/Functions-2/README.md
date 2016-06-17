# Exercise: Functions-2
Write a function that takes three arguments. If the first two are zero, return "FizzBuzz." If the first is zero, return "Fizz." If the second is zero, return "Buzz." Otherwise, return the third argument. Do not use any language features that we haven't yet covered in this book.

## Solution

```
iex> fizz_buzz = fn  
...>   0, 0, c -> "FizzBuzz"  
...>   0, b, c -> "Fizz"  
...>   a, 0, c -> "Buzz"  
...>   a, b, c -> c  
...> end  
#Function<18.50752066/3 in :erl_eval.expr/5>  
iex> fizz_buzz.(0, 0, 3)  
"FizzBuzz"  
iex> fizz_buzz.(1, 0, 3)  
"Buzz"  
iex> fizz_buzz.(0, 2, 3)  
"Fizz"  
iex> fizz_buzz.(1, 2, 3)  
3  
```
