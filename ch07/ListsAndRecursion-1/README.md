# Exercise: ListsAndRecursion-1
Write a *mapsum* function that takes a list and a function. It applies the function to each element of the list and then sums the result, so:

```
iex> MyList.mapsum [1, 2, 3], &(&1 * &1)
14
```

## Solution
See the [my_list.exs](./my_list.exs) file for the full module.

The name pretty much gives this one away. It can be split up into two steps:
- Use Enum.map to apply the function on all elements.
- Use Enum.sum to add up all of the results.

Let's try writing it:
```
def mapsum(items, func) when is_list(items) and is_function(func) do  
  items  
    |> Enum.map(func)  
    |> Enum.sum  
end  
```

Now let's test it.
```
iex> MyList.mapsum [1, 2, 3], &(&1 * &1)  
14  
iex> MyList.mapsum [1, 2, 3, 4], &(&1 + 2)  
18  
```
