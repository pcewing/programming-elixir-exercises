# Exercise: MacrosAndCodeEvaluation-2
Write a macro called *times_n* that takes a single numeric argument. It should define a function called *times_n* in the caller's module that itself takes a single argument, and that multiplies the argument by *n*. So, calling *times_n(3)* should create a function called *times_3*, and calling *times_3(4)* should return 12. Here's an example of it in use:

```
defmodule Test do
  require Times
  Times.times_n(3)
  Times.times_n(4)
end

IO.puts Test.times_3(4) #=> 12
IO.puts Test.times_4(5) #=> 20
```

## Solution
See the [times.exs](./times.exs) file for the full module.

The first thing we need to do is create the function name the macro will define. We can use string interpolation; however, if we just *unquote* the string, we will actually get a *CompileError*. The macro would essentially generate the following:
```
def "times_3"(x) do ...
```

So, let's convert the string to an atom:
```
defmodule Times do
  defmacro times_n(n) do
    fun = String.to_atom("times_#{n}")

    # TODO
  end
end
```

Next, we simply write what the macro should do to define the function. The whole thing looks like:
```
defmodule Times do
  defmacro times_n(n) do
    fun = String.to_atom("times_#{n}")

    quote do
      def unquote(fun)(x) do
        x * unquote(n)
      end
    end
  end
end
```

Using the same *Test* module as was defined in the problem, let's test it in *iex*:
```
iex> Test.times_3(4)
12
iex> Test.times_4(5)
20
```
