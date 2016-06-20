# Exercise: ListsAndRecursion-4
Write a function *MyList.span(from, to)* that returns a list of the numbers from *from* up to *to*.

## Solution
See the [my_list.exs](./my_list.exs) file for the full module.

First off, there is a really easy way to implement this that I will do first:
```
def easy_span(from, to) when is_integer(from) and is_integer(to) and from < to do
  from..to
  |> Enum.to_list
end
```

We create a range and then use the *Enum* module to convert it to a list.

But, seeing as the point of the exercise is to practice lists and recursion, let's do it ourselves too. It's still pretty simple as there are only two cases we really care about:
- We are not at the end of the list.
- We are at the end of the list.

Let's look at case 1:
```
defp do_span(current, last, acc) when current != last do
  do_span(current + 1, last, [current | acc])
end
```
We keep the accumulator handy instead so that we can take advantage of tail recursion optimization. We couldn't if we did something like this:
```
[current | do_span(current + 1, last)]
```
It would work but the call stack would build up. Anyways, all we are doing is adding the current number as the list's head and then recursively calling with the next integer.

Notice that this will create the list in reverse order. This is purposeful; appending to the end of a list linear time whereas prepending is constant time. In the base case we will reverse the list which is a heavily optimized operation.

Now case 2:
```
defp do_span(current, last, acc) when current == last do
  Enum.reverse [current | acc]
end
```

This should look pretty similar. All we are doing is adding the final integer to the front of the list and then reversing the entire thing so it is returned in the correct order. Let's try both the easy implementation and the manual implementation in *iex*:
```
iex> MyList.easy_span(7, 14)
[7, 8, 9, 10, 11, 12, 13, 14]
iex> MyList.span(7, 14)     
[7, 8, 9, 10, 11, 12, 13, 14]
```

Looks good!
