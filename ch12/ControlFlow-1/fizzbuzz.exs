defmodule FizzBuzz do
  def calculate(n) do
    do_fizz_buzz(rem(n, 3), rem(n,5), n)
  end

  defp do_fizz_buzz(a, b, c) do
    case {a, b, c} do
      {0, 0, _c} -> "FizzBuzz"
      {0, _b, _c} -> "Fizz"
      {_a, 0, _c} -> "Buzz"
      {_a, _b, _c} -> c
    end
  end
end
