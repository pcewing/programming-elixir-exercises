defmodule Tracer do
  def dump_args(args) do
    args |> Enum.map(&inspect/1) |> Enum.join(", ")
  end

  def dump_defn(name, args) do
    "#{name}(#{dump_args(args)})"
  end

  # This version will account for a guard clause being present.
  defmacro def({:when,_,[{name,_,args} = definition,_]}, do: content) do
    quote do
      Kernel.def(unquote(definition)) do
        IO.puts "#{IO.ANSI.blue}==> call:   #{Tracer.dump_defn(unquote(name), unquote(args))}"
        result = unquote(content)
        IO.puts "#{IO.ANSI.green}<== result: #{result}"
      end
    end
  end

  defmacro def(definition={name,_,args}, do: content) do
    quote do
      Kernel.def(unquote(definition)) do
        IO.puts "#{IO.ANSI.blue}==> call:   #{Tracer.dump_defn(unquote(name), unquote(args))}"
        result = unquote(content)
        IO.puts "#{IO.ANSI.green}<== result: #{result}"
      end
    end
  end

  defmacro __using__(_opts) do
    quote do
      import Kernel, except: [def: 2]
      import unquote(__MODULE__), only: [def: 2]
    end
  end
end

defmodule Test do
  use Tracer

  #def puts_sum_three(a,b,c), do: IO.inspect(a+b+c)
  #def add_list(list), do: Enum.reduce(list, 0, &(&1 + &2))

  def increment(x) when is_integer(x), do: x + 1
  def increment_by(x, y) when is_integer(x) and is_integer(y), do: x + y
end

#Test.puts_sum_three(1, 2, 3)
#Test.add_list([5, 7, 8])

#Test.add(1, 2)
