# Exercise: StringsAndBinaries-5
Write a function that takes a list of dqs and prints each on a separate line, centered in a column that has the width of the longest string. Make sure it works with UTF characters.
```
iex> center(["cat", "zebra", "elephant"])
  cat
 zebra
elephant
```

## Solution
See the [strings.exs](./strings.exs) file for the full module.

First we should get the length of the longest string. We can do this pretty easily using the Enum.max_by function to get the longest string and then taking its length.
```
width = Enum.max_by(strings, &(String.length(&1)))
|> String.length
```

Next we will want to call our pretty printing helper function on each string like so:
```
Enum.each(strings, fn string -> do_print(string, width) end)
```

Now, let's do the actual work. We should get the difference in length between the string and the total width, then we will want to pad the left side by half of the difference. We can easily create the padding string using String.duplicate to create as many spaces as we need, and finally we can print it using string interpolation.
```
defp do_print(string, width) do
  dlength = width - String.length(string)
  padding = String.duplicate(" ", div(dlength, 2))
  IO.puts "#{padding}#{string}"
end
```

Let's test it:
```
iex> Strings.center(["cat", "zebra", "elephant"])
  cat
 zebra
elephant
:ok
```
