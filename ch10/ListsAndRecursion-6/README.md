# Exercise: ListsAndRecursion-6
(Hard) Write a *flatten(list)* function that takes a list that may contain any number of sublists, which themselves may contain sublists, to any depth. It returns the elements of these lists as a flat list.

```
iex> MyList.flatten([1, [2, 3, [4]], 5, [[[6]]]])
[1, 2, 3, 4, 5, 6]
```

## Solution
See the [my_list.exs](./my_list.exs) file for the full module.

Hard eh? Challenge accepted! Before we start coding, let's think about what' going to happen as we recursively iterate through the list. We may encounter:
- An element (Let's assume integers for now)
- A list

In the case of an element, we should append it to an accumulator, which will be our top-level list. In the case of another list, we should recursively iterate through **that** list the same way we are iterating through the current list. First off, how are we going to differentiate between seeing a basic item and a list? Let's try using guard clauses:
```
def flatten(list) when is_list(list), do: do_flatten(list, [])

defp do_flatten([h | t], acc) when not is_list(h) do
  # TODO
end

defp do_flatten([h | t], acc) when is_list(h) do
  # TODO
end
```

So, the first *do_flatten* should only match when the element *h* is not also a list. The second implementation should only match when it *is* a list. adding in the logic we previously discussed:
```
def flatten(list) when is_list(list), do: do_flatten(list, [])

defp do_flatten([h | t], acc) when not is_list(h), do: do_flatten(t, [h | acc])
defp do_flatten([h | t], acc) when is_list(h), do: do_flatten(h ++ t, acc)
defp do_flatten([], acc), do: Enum.reverse acc
```

This looks a little weird; why are we concatenating the head and tail in that second *do_flatten* clause? Well, concatenation isn't optimal; however, this is the easiest way to make the function tail recursive. We could do something like this also:
```
defp do_flatten([h | t], acc) when not is_list(h), do: do_flatten(t, [h | acc])
defp do_flatten([h | t], acc) when is_list(h), do
  acc ++ do_flatten(h, acc) ++ do_flatten(t, acc)
end
defp do_flatten([], acc), do: Enum.reverse acc
```

But obviously that is even worse because wouldn't get the tail recursion optimization either. I'd have to put more thought into how to optimize this so we are only ever prepending one element and not doing concatenation, but for a quick solution it works:
```
iex> MyList.flatten [1, 2, [3, 4, [[5]]]]
[1, 2, 3, 4, 5]
iex> MyList.flatten [1, 2, [3, 4, [[[5]]]]]
[1, 2, 3, 4, 5]
```
