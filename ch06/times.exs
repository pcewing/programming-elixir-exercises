defmodule Times do
  def double(n), do: n * 2

  def triple(n), do: n * 3
  
  def quadruple(n), do: n |> double |> double
end
