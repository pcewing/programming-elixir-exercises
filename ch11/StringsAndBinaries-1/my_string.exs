defmodule MyString do
  def printable?(string) do
    do_printable(string)
  end

  defp do_printable([h | t]) when h > 31 and h < 127, do: do_printable(t)
  defp do_printable([h | _t]) when h < 32 or h > 126, do: false 
  defp do_printable([]), do: true
end
