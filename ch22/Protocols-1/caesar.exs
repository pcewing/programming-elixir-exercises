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

string = "Hello, world!"
IO.puts "Original string: \"#{string}\""
IO.puts "Shifted by 3: #{Encryptable.encrypt(string, 3)}"
IO.puts "Shifted by 13 (ROT13): #{Encryptable.rot13(string)}"

list = String.to_char_list(string)
IO.puts "Original char list: \"#{list}\""
IO.puts "Shifted by 3: #{Encryptable.encrypt(list, 3)}"
IO.puts "Shifted by 13 (ROT13): #{Encryptable.rot13(list)}"
