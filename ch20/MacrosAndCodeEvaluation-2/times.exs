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

defmodule Test do
  require Times
  Times.times_n(3)
  Times.times_n(4)
end
