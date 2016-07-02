# Exercise: ListsAndRecursion-2
Write a *max(list)* that returns the element with the maximum value in the list. (This is slightly trickier than it sounds.)

## Solution
See the [my_list.exs](./my_list.exs) file for the full module.

I'm guessing the "tricky" part is that we need to keep track of the current max. We'll use a private helper for this. We can do everything using pattern matching and guard clauses; we just need to consider the four possible cases:
- We are looking at the first element in the list; no current max is held so set the element as the current max.
- The element we are looking at is less than or equal to the current max; leave the current max alone and move on.
- The element we are looking at is greater than the current max; update the current max and move on.
- The list is empty. This is how we know we are done; return the current max.

When we put it all together, it looks like:
```
defmodule MyList do
  def max(items) when is_list(items) do
    do_max(items)
  end

  defp do_max([h | t]), do: do_max(t, h)
  defp do_max([h | t], current_max) when h > current_max, do: do_max(t, h)
  defp do_max([h | t], current_max) when h <= current_max, do: do_max(t, current_max)
  defp do_max([], current_max), do: current_max
end
```

This could be consolidated even more as we don't really need the first *do_max* definition; however, I chose to separate the two to make it more readable.

In *iex*:
```
iex> MyList.max [1, 2, 3]
3
iex> MyList.max [1, 2, 3, 2, 7, 4]
7
```
