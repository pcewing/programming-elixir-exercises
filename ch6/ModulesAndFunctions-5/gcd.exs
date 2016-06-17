defmodule GCD do
  def calculate(x, y) when is_integer(x) and is_integer(y) and x >= 0 and y >= 0,
    do: do_calculate(x, y)
  def calculate(x, y) when not is_integer(x) or not is_integer(y) or x < 0 and y < 0,
    do: {:error, "Expected two positive integers."}

  defp do_calculate(x, 0), do: x
  defp do_calculate(x, y), do: do_calculate(y, rem(x, y))
end
