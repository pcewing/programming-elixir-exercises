# Exercise: ListsAndRecursion-7
In the last exercise of Chapter 7, *Lists and Recursion*, on page 61, you wrote a *span* function. Use it and list comprehensions to return a list of the prime numbers from 2 to *n*.

## Solution
See the [prime_finder.exs](./prime_finder.exs) file for the full module.

Recall the *easy_span* function we wrote. I am going to consolidate it a bit and use it again here:
```
def do_span(from, to) when is_integer(from) and is_integer(to) and from < to,
  do: from..to |> Enum.to_list
```

Now, how should we go about doing this? Here's my idea. Let's write a function that given an integer *n*, returns *true* or *false* depending on whether or not that number is prime. Then, we can use *Enum.filter* with our method to filter down the span. A number is prime if it is only divisible into a whole number by 1 and itself.
```
def is_prime(n) do
  case n do
    1 -> false
    x when x < 4 -> true
    x when x == 5 or x == 7 -> true
    x when x == 4 or x == 6 -> false
    x -> do_span(2, div(x, 2) - 1) |> do_check_divs(x)
  end
end

defp do_check_divs([h | t], n) do
  case rem(n, h) == 0 do
    true -> false
    false -> do_check_divs(t, n)
  end
end
defp do_check_divs([], _n), do: true
```

Let's test this helper out first to make sure it works. We create a span of numbers from *2* to *(n / 2) - 1*; this is the span of numbers that are possible divisors. If *n* is a multiple of any of these, we know it's not prime. We have to evaluate 1 through 7 manually as the formula *(n / 2) - 1* will only work for numbers greater than 7.

Now let's write the main function.
```
def do_find(n) do
  do_span(1, n)
    |> Enum.filter(&(do_is_prime(&1)))
end
```

All we have to do is filter the list down to the numbers that are prime. Let's test it:
```
iex> PrimeFinder.find 4
[1, 2, 3]
iex> PrimeFinder.find 20
[1, 2, 3, 5, 7, 11, 13, 17, 19]
```

Those look like primes to me! This is a horribly inefficient implementation. Even by just adding some basic short circuiting for numbers divisible by two and three we could probably increase the speed by an order of magnitude. Nevertheless, the problem was to create the list of primes from 2 to *n* and we accomplished that. Let's not worry about optimizing everything yet.
