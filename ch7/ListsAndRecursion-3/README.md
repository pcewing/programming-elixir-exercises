# Exercise: ListsAndRecursion-3
An Elixir single-quoted string is actually a list of individual character codes. Write a *caesar(list, n)* function that adds *n* to each list element, wrapping if the addition results in a character greater than z.
```
iex> MyList.caesar('ryvkve', 13)
?????? :)
```

## Solution
See the [my_list.exs](./my_list.exs) file for the full module.

The problem said wrap if greater than z, but we're going to make this work for both lower and upper case ASCII characters. So, there will be two cases we need to worry about:
- Character is lower case (96 < char < 123)
- Character is upper case (64 < char < 91)

In both cases we will do the same thing; add the integer *n* to the character code and then either return the new character code, or the character code - 26 if it is greater than 123 or 91 respectively.

```
defmodule MyList do
  def caesar(char_list, n) when is_list(char_list) and is_integer(n) do
    char_list
      |> Enum.map(fn c -> do_obscure(c, n) end)
  end

  # Obscure upper case letter.
  defp do_obscure(char, n) when char > 64 and char < 91 do
    case char + n do
      new_char when new_char > 90 -> new_char - 26
      new_char when new_char < 91 -> new_char
    end
  end

  # Obscure lower case letter.
  defp do_obscure(char, n) when char > 96 and char < 123 do
    case char + n do
      new_char when new_char > 122 -> new_char - 26
      new_char when new_char < 123 -> new_char
    end
  end
end
```

Simple enough, let's test it:
```
iex> MyList.caesar('abc', 2)
'cde'
iex> MyList.caesar('Paul', 2)
'Rcwn'
iex> MyList.caesar('xyz', 3) 
'abc'
```
