defmodule MyList do
  def max(items) when is_list(items) do
    do_max(items)
  end

  defp do_max([h | t]), do: do_max(t, h)
  defp do_max([h | t], current_max) when h > current_max, do: do_max(t, h)
  defp do_max([h | t], current_max) when h <= current_max, do: do_max(t, current_max)
  defp do_max([], current_max), do: current_max
end
