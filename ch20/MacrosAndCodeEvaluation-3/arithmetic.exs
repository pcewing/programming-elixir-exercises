defmodule Arithmetic do
  defmacro explain(clauses) do
    do_clause = Keyword.get(clauses, :do, nil)
    do_explain(do_clause, nil)
  end

  defp do_explain({op, _, [a, b]}, nil) when is_integer(a) and is_integer(b),
    do: do_translate(op, a, b)

  defp do_explain({op, _, [a, b]}, acc) when is_integer(a) and is_integer(b),
    do: acc <> ", then #{do_translate(op, a, b)}"

  defp do_explain({op, _, [a, b]}, acc) when is_integer(a) and is_tuple(b),
    do: do_explain(b, acc) <> do_translate(op, a)

  defp do_explain({op, _, [a, b]}, acc) when is_tuple(a) and is_integer(b),
    do: do_explain(a, acc) <> do_translate(op, b)

  defp do_explain({op, _, [a, b]}, acc) when is_tuple(a) and is_tuple(b) do
    acc = do_explain(a, acc)
    acc = do_explain(b, acc)
    acc <> do_translate(op)
  end

  defp do_translate(:+, a, b) when is_integer(a) and is_integer(b), do: "add #{a} to #{b}"
  defp do_translate(:-, a, b) when is_integer(a) and is_integer(b), do: "subtract #{b} from #{a}"
  defp do_translate(:*, a, b) when is_integer(a) and is_integer(b), do: "multiply #{a} by #{b}"
  defp do_translate(:/, a, b) when is_integer(a) and is_integer(b), do: "divide #{a} by #{b}"

  defp do_translate(:+, x) when is_integer(x), do: ", then add #{x}"
  defp do_translate(:-, x) when is_integer(x), do: ", then subtract by #{x}"
  defp do_translate(:*, x) when is_integer(x), do: ", then multiply by #{x}"
  defp do_translate(:/, x) when is_integer(x), do: ", then divide by #{x}"

  defp do_translate(:+), do: ", then add the results"
  defp do_translate(:-), do: ", then the second result from the first"
  defp do_translate(:*), do: ", then multiply the results"
  defp do_translate(:/), do: ", then divide the first result by the second"
end

defmodule Test do
  require Arithmetic

  def test do
    IO.puts "Explaining: 1 + 2 * 3"
    sentence = Arithmetic.explain do: 1 + 2 * 3
    IO.puts sentence

    IO.puts "Explaining: 1 * 2 + 3"
    sentence = Arithmetic.explain do: 1 * 2 + 3
    IO.puts sentence

    IO.puts "Explaining: 1 * 2 + 3 * 4"
    sentence = Arithmetic.explain do: 1 * 2 + 3 * 4
    IO.puts sentence

    IO.puts "Explaining: 3 * 4 + 1 / 3 - 3 + 1"
    sentence = Arithmetic.explain do: 3 * 4 + 1 / 3 - 3 + 1
    IO.puts sentence
  end
end
