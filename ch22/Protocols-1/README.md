# Exercise: Protocols-1
A basic Caesar cypher consists of shifting the letters in a message by a fixed offset. For an offset of 1, for example, a will become b, b will become c, and z will become a. If the offset is 13, we have the ROT13 algorithm.

Lists and binaries can both be *stringlike*. Write a *Caesar* protocol that applies to both. It would include two functions: *encrypt(string, shift)* and *rot13(string)*.

## Solution
See the [caesar.exs](./caesar.exs) file for the full solution.

I actually started off by writing what it would look like to use the protocol. Over the past few days I read the first ~200 pages of *Elixir in Action*, and the author uses this technique a lot (Writing the expected usage of a module before writing the module) and I like it. So, here's how I expect the module to look:
```
string = "Hello, world!"
IO.puts "Original string: \"#{string}\""
IO.puts "Shifted by 3: #{Encryptable.encrypt(string, 3)}"
IO.puts "Shifted by 13 (ROT13): #{Encryptable.rot13(string)}"

list = String.to_char_list(string)
IO.puts "Original char list: \"#{list}\""
IO.puts "Shifted by 3: #{Encryptable.encrypt(list, 3)}"
IO.puts "Shifted by 13 (ROT13): #{Encryptable.rot13(list)}"
```

First we create a regular string (binary) and print it's actual value followed by the result of shifting the characters by three and thirteen. Then we make a character list out of the binary string and do the same thing.

So, here's what the protocol looks like:
```
defprotocol Encryptable do
  def encrypt(string, shift)
  def rot13(string)
end
```

Pretty dang simple and easy to interpret. Let's do the string implementation first since it will be identical to the character list implementation with some additional conversions to make the string simpler to parse. To my knowledge, Strings don't implement the Enumerable protocol the way lists and maps do, so we first convert the string to a character list. Then, we can use *Enum.map* which will, for every character, call a separate function that will shift the specific character.
```
defimpl Encryptable, for: BitString do
  def encrypt(string, shift) do
    string
    |> String.to_char_list
    |> Enum.map(&Char.shift(&1, shift))
    |> List.to_string
  end

  def rot13(string) do
    encrypt(string, 13)
  end
end
```

Note that for the *ROT13* function, we can just utilize the encrypt method instead of duplicating any code. Let's take a quick look at the *Char* module we need in order to shift each character:
```
defmodule Char do
  def shift(char, shift) when char < 0x5b and char > 0x40 do
    case char + shift do
      new_char when new_char >= 0x5b -> new_char - 26
      new_char when new_char <= 0x40 -> new_char + 26
      new_char -> new_char
    end
  end

  def shift(char, shift) when char < 0x7b and char > 0x60 do
    case char + shift do
      new_char when new_char >= 0x7b -> new_char - 26
      new_char when new_char <= 0x60 -> new_char + 26
      new_char -> new_char
    end
  end

  def shift(char, _), do: char
end
```
This should also be pretty self explanatory, apart from the magical numbers in the guard clauses. Those numbers are just the ASCII ranges of a-z and A-Z. We only want to shift letters, not punctuation. In the function bodies, we either return the raw shifted value, or if the raw shifted value moved outside the acceptable range, we rotate it back in. (There is a bug in here if shift is greater than 26 but that could be easily addressed with an additional check in the guard clauses.)

Now that our string implementation is done and the helper module is written, let's implement the list version. As previously stated, the list version is actually the same exact logic, minus the conversions which are now unnecessary:
```
defimpl Encryptable, for: List do
  def encrypt(string, shift) do
    string
    |> Enum.map(&Char.shift(&1, shift))
  end

  def rot13(string) do
    encrypt(string, 13)
  end
end
```

Running it in *iex* we get:
```
$ iex caesar.exs

Original string: "Hello, world!"
Shifted by 3: Khoor, zruog!
Shifted by 13 (ROT13): Uryyb, jbeyq!
Original char list: "Hello, world!"
Shifted by 3: Khoor, zruog!
Shifted by 13 (ROT13): Uryyb, jbeyq!
```
