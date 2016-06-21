defmodule Strings do
  def center(strings) do
    width = Enum.max_by(strings, &(String.length(&1)))
    |> String.length
    Enum.each(strings, fn string -> do_print(string, width) end)
  end

  defp do_print(string, width) do
    dlength = width - String.length(string)
    padding = String.duplicate(" ", div(dlength, 2))
    IO.puts "#{padding}#{string}"
  end
end
