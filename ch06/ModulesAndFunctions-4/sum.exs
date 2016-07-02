defmodule Sum do
  def calculate(n) when is_integer(n) and n >= 0, do: do_calculate n
  def calculate(n) when not is_integer(n) or n < 0, do: {:error, "Expected a positive integer."}

  defp do_calculate(0), do: 0
  defp do_calculate(1), do: 1
  defp do_calculate(n), do: n + do_calculate(n - 1)
end
