# Exercise: MacrosAndCodeEvaluation-3
The Elixir test framework, *ExUnit*, uses some clever code-quoting tricks. For example, if you assert
```
assert 5 < 4
```
You'll get the eror "expected 5 to be less than 4."

The Elixir source code is on GitHub (at *https://github.com/elixir-lang/elixir*). The implementation of this is in the file *elixir/lib/ex_unit/assertions.ex*. Spend some time reading this file, and work out how it implements this trick.

(Hard) Once you've done that, see if you can use the same technique to implement a function that takes an arbitrary arithmetic expression and returns a natural language version.
```
explain do: 2 + 3 * 4
#=> multiply 3 and 4, then add 2
```

## Solution
See the [arithmetic.exs](./arithmetic.exs) file for the full module.

To start off, I'm just going to get a better feel for the code respresentation of arithmetic expressions. Let's define a macro that will just print the expression:
```
defmodule Arithmetic do
  defmacro print(clause) do
    IO.puts inspect clause
  end
```

And let's print some:
```
iex> require Arithmetic
nil
iex> Arithmetic.print 1+2
{:+, [line: 2], [1, 2]}
:ok
iex> Arithmetic.print 1+2 * 7
{:+, [line: 3], [1, {:*, [line: 3], [2, 7]}]}
:ok
iex> Arithmetic.print 1 + 2 - 3 / 4 * 7
{:-, [line: 4], [{:+, [line: 4], [1, 2]}, {:*, [line: 4], [{:/, [line: 4], [3, 4]}, 7]}]}
:ok
```

Let's take that last one and format it a little better so we can think about what it means:
```
{:-, [], [
  {:+, [], [1, 2]},
  {:*, [], [
    {:/, [], [3, 4]},
    7
  ]}
]}
```

Aha, so we basically have a tree where the deeper into the tree we get, the higher priority the operation is. Given an operation, there will be 4 cases we need to handle:
- Both operands are ints
- The left operand is an int but the right is a tuple (A sub-operation)
- The right operand is an int but the left is a tuple (A sub-operation)
- Both operands are tuples

We will need to be able to translate three types of strings:
- Two integer operands (E.g. multiply 1 and 2)
- One integer operand (E.g. then add 4)
- No integer opernds (E.g. then add the results)

Putting it all together:
```
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
```

The actual macro is really simple:
```
defmacro explain(clauses) do
  do_clause = Keyword.get(clauses, :do, nil)
  do_explain(do_clause, nil)
end
```

Neat!
