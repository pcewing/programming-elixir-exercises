# Exercise: StringsAndBinaries-1
Write a function that returns *true* if a single-quoted string contains only printable ASCII characters (space through tilde).

## Solution
See the [my_string.exs](./my_string.exs) file for the full module.

Recall that a single-quoted string is just a list of character codes. So, we can recursively iterate through each character and check whether or not the character is printable. We can even accomplish this using guard clauses to make our function implementations extremely simple.
```
def printable?(string) do
  do_printable(string)
end

defp do_printable([h | t]) when h > 31 and h < 127, do: do_printable(t)
defp do_printable([h | _t]) when h < 32 or h > 126, do: false
defp do_printable([]), do: true
```

In *iex*:
```
iex> MyString.printable? 'Hello'
true
iex> MyString.printable? [0, 2]
false
```
