# Exercise: LinkingModules-BehavioursAndUse-3
(Hard) Try adding a method definition with a guard clause to the *Test* module. You'll find that the tracing no longer works.
- Find out why.
- See if you can fix it.

## Solution
See the [tracer.exs](./tracer.exs) file for the full module.

I'm going to start off by printing what the arguments now look like. Change the macro to this temporarily:
```
defmacro def(definition, do: content) do
  IO.puts inspect definition
end
```
Let's use it in a basic function with a single guard clause:
```
def increment(x) when is_integer(x), do: x + 1
```
And see what it outputs:
```
{:when, [line: 38], [{:increment, [line: 38], [{:x, [line: 38], nil}]}, {:is_integer, [line: 38], [{:x, [line: 38], nil}]}]}
```
Reformatted for readability:
```
{:when, [line: 38],
  [
    {:increment, [line: 38], [{:x, [line: 38], nil}]},
    {:is_integer, [line: 38], [{:x, [line: 38], nil}]}
  ]}
```

Aha, so it looks like *:when* is an operation where the second operand is a condition and the first operand is the operation to execute if the condition is met. Let's see if this changes with an additional guard clause:
```
def increment_by(x, y) when is_integer(x) and is_integer(y), do: x + y
```
The formatted output:
```
{:when, [line: 39],
  [
    {:increment_by, [line: 39], [{:x, [line: 39], nil}]},
    {:and, [line: 39],
      [
        {:is_integer, [line: 39], [{:x, [line: 39], nil}]},
        {:is_integer, [line: 39], [{:y, [line: 39], nil}]}
      ]}
  ]}
```
Cool! Even though it appears we added an "additional" guard clause, it's just an extension of the same clause using *and*. Let's try to account for a possible guard clause:
```
defmacro def({:when,_,[{name,_,args} = definition,_]}, do: content) do
  quote do
    Kernel.def(unquote(definition)) do
      IO.puts "#{IO.ANSI.blue}==> call:   #{Tracer.dump_defn(unquote(name), unquote(args))}"
      result = unquote(content)
      IO.puts "#{IO.ANSI.green}<== result: #{result}"
    end
  end
end
```

I am making the assumption that the arguments for *when* will always be ordered correctly.

Let's test it out:
```
iex> Test.increment_by(1,2)
==> call:   increment_by(1, 2)
<== result: 3
:ok
iex> Test.increment(2)
==> call:   increment(2)
<== result: 3
:ok
```

Nice. This makes me excited for the *Metaprogramming Elixir* book which is next on my reading list!
