defmodule MyString do
  def anagram?(word1, word2) when is_list(word1) and is_list(word2),
    do: anagram?(List.to_string(word1), List.to_string(word2))
  def anagram?(word1, word2) when is_list(word1) and is_binary(word2),
    do: anagram?(List.to_string(word1), word2)
  def anagram?(word1, word2) when is_binary(word1) and is_list(word2),
    do: anagram?(word1, List.to_string(word2))
  def anagram?(word1, word2) when is_binary(word1) and is_binary(word2),
    do: word1 == String.reverse word2
end
