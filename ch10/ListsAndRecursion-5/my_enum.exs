defmodule MyEnum do
  def all?(list, condition) when is_list(list) and is_function(condition) do
    do_all(list, condition)
  end

  defp do_all([h | t], condition) do
    case condition.(h) do
      true -> do_all(t, condition)
      false -> false
    end
  end
  defp do_all([], _), do: true

  def each(list, fun) when is_list(list) and is_function(fun) do
    do_each(list, fun)
  end

  defp do_each([h | t], fun) do
    fun.(h)
    do_each(t, fun)
  end
  defp do_each([], _), do: :ok

  def filter(list, condition) when is_list(list) and is_function(condition) do
    do_filter(list, condition, [])
    |> Enum.reverse
  end

  defp do_filter([h | t], condition, acc) do
    case condition.(h) do
      true -> do_filter(t, condition, [h | acc])
      false -> do_filter(t, condition, acc)
    end
  end
  defp do_filter([], _, acc), do: acc

  def split(list, split_on) when is_list(list) do
    do_split(list, split_on, [])
  end

  defp do_split([h | t], split_on, acc) do
    case h == split_on do
      true -> { Enum.reverse([h | acc]), t}
      false -> do_split t, split_on, [h | acc]
    end
  end
  defp do_split([], _split_on, acc), do: {Enum.reverse(acc), []}

  def take(list, n) when is_list(list) and is_integer(n) and n > 0, do: do_take(list, n, [])

  defp do_take([h | t], n, acc) when n > 0, do: do_take(t, n - 1, [ h | acc])
  defp do_take(_, n, acc) when n == 0, do: Enum.reverse acc
  defp do_take([], _, acc), do: Enum.reverse acc
end
