defmodule MyList do
  def flatten(list) when is_list(list), do: do_flatten(list, [])

  defp do_flatten([h | t], acc) when not is_list(h), do: do_flatten(t, [h | acc])
  defp do_flatten([h | t], acc) when is_list(h), do: do_flatten(h ++ t, acc)
  defp do_flatten([], acc), do: Enum.reverse acc
end
