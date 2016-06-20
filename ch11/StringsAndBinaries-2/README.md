# Exercise: StringsAndBinaries-2
Write an *anagram?(word1, word2)* that returns *true* if its parameters are anagrams.

## Solution
See the [my_string.exs](./my_string.exs) file for the full module.

The problem doesn't specify if the parameters should be strings or char lists. I'll implement it for both and the mixed cases since the logic itself is only one line.
```
def anagram?(word1, word2) when is_list(word1) and is_list(word2),
  do: anagram?(List.to_string(word1), List.to_string(word2))
def anagram?(word1, word2) when is_list(word1) and is_binary(word2),
  do: anagram?(List.to_string(word1), word2)
def anagram?(word1, word2) when is_binary(word1) and is_list(word2),
  do: anagram?(word1, List.to_string(word2))
def anagram?(word1, word2) when is_binary(word1) and is_binary(word2),
  do: word1 == String.reverse word2
```

There are four cases here but note that only the last one does the actual check. The first three simply convert any character lists into binaries and then call the function again. When it is called again, the last clause should then match and the check should be done.

The check itself is simple, if the first word is equal to the reverse of the second word, the words are anagrams.

In *iex*:
```
iex> MyString.anagram? "Paul", "luaP"
true
iex> MyString.anagram? "Paul", 'luaP'
true
iex> MyString.anagram? "Paul", "paul"
false
```
