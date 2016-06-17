# Exercise: ModulesAndFunctions-6
*I'm thinking of a number between 1 and 1000...*

The most efficient way to find the number is to guess halfway between the low and high numbers of the range. If our guess is too big, then the answer lies between the bottom of the range and one less than our guess. If our guess is too small, then the answer lies between one more than our guess and the end of the range.

Your API will be *guess(actual, range)*, where *range* is an Elixir range.

Your output should look similar to this:

```
iex> Chop.guess(273, 1..1000)
Is it 500
Is it 250
Is it 375
Is it 312
Is it 281
Is it 265
Is it 273
273
```

## Solution
See the [chop.exs](./chop.exs) file for the full module.

The first order of business is figuring out how to calculate our guess. It should be simple enough; we just need to get the middle point of the range. It turns out I couldn't find a way to do this built into Elixir, so I wrote myself a little helper function.
```
defp do_get_middle(%Range{} = range) do
  min..max = range
  count = max - min + 1
  max - div(count, 2)
end
```

It will calculate the exact middle for a range containing an odd number of items, or the integer below the exact middle for ranges containing an even number of items (I.e. *do_get_middle(1..4) => 2*).

Next is adding the public function definition to call our private helpers. I discovered that there is also no *is_range* method in Elixir but that a range is actually just a struct. So, we can use pattern matching in the function signature to ensure a range is passed:
```
def guess(n, %Range{} = range) when is_integer(n) do
  if not n in range do
    raise RuntimeError, message: "The integer provided is not in the range."
  end

  guess = do_get_middle range
  do_guess(n, range, guess)
end
```
Unfortunately, there is no guard clause or pattern matching capable of verifying that the integer is in the range, so the first thing we should do is make sure it is and raise an exception if it's not.

Then, we calculate our initial guess and call our worker methods. The worker methods are the fun part because we've already sanitized the input; now we just get to do the real work. There are only three cases we care about:
- Our guess is correct
- Our guess is too low
- Our guess is too high

We can check all three of these things using guard clauses! Here's our function signatures:
```
  defp do_guess(n, _range, guess) when n == guess do
    # TODO
  end

  defp do_guess(n, range, guess) when n < guess do
    # TODO
  end

  defp do_guess(n, range, guess) when n > guess do
    # TODO
  end
```

Now, we just have a little bit of logic to add. The first case is easy; we found the number we are looking for so let's just print and return it.
```
defp do_guess(n, _range, guess) when n == guess do
  IO.puts "Is it #{guess}"
  guess
end
```

The next two cases are nearly identical. In both cases all we need to do is adjust the range and make a new guess. If our guess was to low, we adjust the range so that it only contains values higher than our guess. Likewise, if our guess was too high, we adjust the range so that it only contains values lower than our guess. Then, in both cases, we just formulate a new guess and try again with the new range.
```
defp do_guess(n, range, guess) when n < guess do
  IO.puts "Is it #{guess}"

  min.._max = range
  new_max = guess - 1
  new_range = min..new_max
  new_guess = do_get_middle(new_range)
  do_guess(n, new_range, new_guess)
end

defp do_guess(n, range, guess) when n > guess do
  IO.puts "Is it #{guess}"

  _min..max = range
  new_min = guess + 1
  new_range = new_min..max
  new_guess = do_get_middle(new_range)
  do_guess(n, new_range, new_guess)
end
```

The code could certainly be consolidated but I left it verbose to keep everything as clear as possible. Lastly, let's try it out:
```
iex> Chop.guess(273, 1..1000)
Is it 500
Is it 250
Is it 375
Is it 312
Is it 281
Is it 265
Is it 273
273
iex> Chop.guess(9,1..20)     
Is it 10
Is it 5
Is it 7
Is it 8
Is it 9
9
iex> Chop.guess(2473, 1..10000)
Is it 5000
Is it 2500
Is it 1250
Is it 1875
Is it 2187
Is it 2343
Is it 2421
Is it 2460
Is it 2480
Is it 2470
Is it 2475
Is it 2472
Is it 2473
2473
```

That's pretty neat!
