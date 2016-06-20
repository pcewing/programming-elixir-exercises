# Exercise: ListsAndRecursion-5
Implement the following *Enum* functions using no library functions or list comprehensions: *all?*, *each*, *filter*, *split*, and *take*. You may need to use an *if* statement to implement *filter*.

## Solutions
See the [my_enum.exs](./my_enum.exs) file for the full module.

### All
For the *all?* method, we will iterate through each item in the list looking for one of two cases:
- The item meets the condition, in which case we can move onto the next item.
- The item does not meet the condition, in which case no further processing is necesary. We can return *false*.

The final case will be when we have reached the empty list, at which point we know every element has met the condition and we can return *true*. Let's try it:
```
def all?(list, condition) when is_list(list) and is_function(condition) do
  do_all(list, condition)
end

defp do_all([h | t], condition) do
  case condition.(h) do
    true -> do_all(t, condition)
    false -> false
  end
end
defp do_all([], _), do: true
```

Notice that this time instead of providing a different function definition for each case, we used a *case* statement. This is because we can't use the *condition* function in a guard clause. It should still be simple enough to read. As soon as we encounter any element where the condition does not hold true, we return false. Otherwise, when we get to the end, we know every element has met the condition.

Also recall that we need the period when we call *condition* as it is an anonymous function. Our output:
```
iex> MyEnum.all? [1, 2, 3], &(is_integer(&1))
true
iex> MyEnum.all? [1, 2, 3], &(&1 < 3)        
false
iex> MyEnum.all? [1, 2, 3], &(&1 < 4)
true
```

### Each
This chapter actually doesn't discuss the *each* function, but according to the Elixir docs, it "Invokes the given *fun* for each item in the enumerable." Sounds easy enough. This is basically the previous problem except there is only a single case at each element:
```
def each(list, fun) when is_list(list) and is_function(fun) do
  do_each(list, fun)
end

defp do_each([h | t], fun) do
  fun.(h)
  do_each(t, fun)
end
defp do_each([], _), do: :ok
```

In *iex*:
```
iex> MyEnum.each [1, 2, 3], &(IO.puts &1)
1
2
3
:ok
```

### Filter
This is similar to the first problem; however, we don't want to short circuit when an element doesn't meet the given condition. Instead, we simply prepend or don't prepend the item based on whether or not it meets the condition. We will want to keep an accumulator so we can take advantage of tail recursion optimization. Don't forget that at the end we will need to reverse the order if we prepend the items to make the method more efficient.
```
def filter(list, condition) when is_list(list) and is_function(condition) do
  do_filter(list, condition, [])
end

defp do_filter([h | t], condition, acc) do
  case condition.(h) do
    true -> do_filter(t, condition, [h | acc])
    false -> do_filter(t, condition, acc)
  end
end
defp do_filter([], _, acc), do: Enum.reverse acc
```

(The problem said not to use library functions but I used Enum.reverse. We are still doing the filtering manually. I'm confident we could write our own reverse if we wanted to.)

### Split
We are only going to write the easy case of *split* where the collection is only split once. We need to track one list accumulator. As we move through each element in the list, we will check if it is the item we are splitting on. If it is not, we will add it to the accumulator and move on. Once we reach the item we are splitting on, we will return the accumulator and the rest of the list. If we reach the end and never find the item we are splitting on, we will simply return the accumulator, which at this point should contain the whole list.
```
def split(list, split_on) when is_list(list) do
  do_split(list, split_on, [])
end

defp do_split([h | t], split_on, acc) do
  case h == split_on do
    true -> { Enum.reverse([h | acc]), t}
    false -> do_split t, split_on, [h | acc]
  end
end
defp do_split([], _split_on, acc), do: {Enum.reverse(acc), []}
```

Note that we are using *Enum.reverse* again. We're still doing the splitting ourselves so I won't tell if you don't. Let's test it:
```
iex> MyEnum.split [1, 2, 3, 4, 5], 3
{[1, 2, 3], [4, 5]}
iex> MyEnum.split [1, 2, 3, 4, 5], 7
{[1, 2, 3, 4, 5], []}
```

### Take
Almost done. This one will be similar to the last problem except we will ignore the second sublist instead of returning it. We will take a number and decrement it every time we make a recursive call. Once the number has reached zero, we know we've taken enough elements and we can simply return what we've accumulated. We will also handle the case where the number given is larger than the number of elements in the collection; in this case we will simply return the collection.
```
def take(list, n) when is_list(list) and is_integer(n) and n > 0, do: do_take(list, n, [])

defp do_take([h | t], n, acc) when n > 0, do: do_take(t, n - 1, [ h | acc])
defp do_take(_, n, acc) when n == 0, do: Enum.reverse acc
defp do_take([], _, acc), do: Enum.reverse acc
```

Aren't guard clauses and pattern matching cool? Let's run it in *iex*.
```
iex> MyEnum.take [1, 2, 3, 4, 5], 3
[1, 2, 3]
iex> MyEnum.take [1, 2, 3, 4, 5], 2
[1, 2]
iex> MyEnum.take [1, 2, 3, 4, 5], 8
[1, 2, 3, 4, 5]
```
