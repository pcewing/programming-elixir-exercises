defprotocol Encryptable do
  def encrypt(string, shift)
  def rot13(string)
end

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

defimpl Encryptable, for: List do
  def encrypt(string, shift) do
    string
    |> Enum.map(&Char.shift(&1, shift))
  end

  def rot13(string) do
    encrypt(string, 13)
  end
end

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

defmodule Test do
  def test do
    words = "words.txt"
    |> File.stream!
    |> Stream.map(&String.strip(&1))
    |> Enum.reduce(MapSet.new, fn(word, acc) -> MapSet.put(acc, word) end)

    words
    |> Enum.reduce([], fn(word, acc) -> update_results(word, words, acc) end)
    |> IO.inspect
  end

  def rotation_exists?(word, words) do
    rotated = Encryptable.rot13(word)
    MapSet.member?(words, rotated)
  end

  def update_results(word, words, acc) do
    case rotation_exists?(word, words) do
      true -> [word | acc]
      false -> acc
    end
  end
end
