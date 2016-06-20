defmodule PrimeFinder do
  require Integer

  def find(n) when is_integer(n) and n > 0, do: do_find(n)

  def do_find(n) do
    do_span(1, n)
      |> Enum.filter(&(do_is_prime(&1)))
  end

  def do_span(from, to) when is_integer(from) and is_integer(to) and from < to,
    do: from..to |> Enum.to_list

  def do_is_prime(n) do
    case n do
      1 -> false
      x when x < 4 -> true
      x when x == 4 or x == 6 -> false
      x when x == 5 or x == 7 -> true
      x -> do_span(2, div(x, 2) - 1) |> do_check_divs(x)
    end
  end

  defp do_check_divs([h | t], n) do
    case rem(n, h) == 0 do
      true -> false
      false -> do_check_divs(t, n)
    end
  end
  defp do_check_divs([], _n), do: true
end
