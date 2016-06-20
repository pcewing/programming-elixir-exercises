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
