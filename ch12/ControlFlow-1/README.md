# Exercise: ControlFlow-1
Rewrite the FizzBuzz example using case.

## Solution
See the [fizzbuzz.exs](./fizzbuzz.exs) file for the full module.

Recall our previous solution to fizz buzz:
```
fizz_buzz_helper = fn  
  0, 0, c -> "FizzBuzz"  
  0, b, c -> "Fizz"  
  a, 0, c -> "Buzz"  
  a, b, c -> c  
end  

fizz_buzz = fn n -> fizz_buzz_helper.(rem(n, 3), rem(n,5), n) end  
```

Looks easy enough to convert. Let's write the public method:
```
def calculate(n) do
  do_fizz_buzz(rem(n, 3), rem(n,5), n)
end
```

Which will call a private helper:
```
defp do_fizz_buzz(a, b, c) do
  case {a, b, c} do
    {0, 0, _c} -> "FizzBuzz"
    {0, _b, _c} -> "Fizz"
    {_a, 0, _c} -> "Buzz"
    {_a, _b, _c} -> c
  end
end
```

The only difference is that in the *case* statement we wrap the values in a tuple as a single condition is expected.

In *iex*:
```
iex> FizzBuzz.calculate(5)
"Buzz"
iex> 1..15 |> Enum.to_list |> Enum.map(&FizzBuzz.calculate(&1))
[1, 2, "Fizz", 4, "Buzz", "Fizz", 7, 8, "Fizz", "Buzz", 11, "Fizz", 13, 14,
 "FizzBuzz"]
 ```
