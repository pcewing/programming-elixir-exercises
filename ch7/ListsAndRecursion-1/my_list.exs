defmodule MyList do
  def mapsum(items, func) when is_list(items) and is_function(func) do
    items
      |> Enum.map(func)
      |> Enum.sum
  end
end
