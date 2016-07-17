defmodule MyEnum do
  def each(enumerable, fun) do
    reducer = fn(elem, _acc) ->
      fun.(elem)
      {:cont, nil}
    end

    enumerable
    |> Enumerable.reduce({:cont, nil}, reducer)

    :ok
  end

  def filter(enumerable, fun) do
    reducer = fn(elem, acc) ->
      case fun.(elem) do
          true -> {:cont, [elem | acc]}
          false -> {:cont, acc}
      end
    end

    {:done, result} = enumerable
    |> Enumerable.reduce({:cont, []}, reducer)

    result
    |> Enum.reverse
  end

  def map(enumerable, fun) do
    reducer = fn(elem, acc) ->
      {:cont, [fun.(elem) | acc]}
    end

    {:done, result} = enumerable
    |> Enumerable.reduce({:cont, []}, reducer)

    result
    |> Enum.reverse
  end
end

defmodule Test do
  def test_each do
    [1, 2, 3, 4, 5]
    |> MyEnum.each(&(IO.puts &1))
  end

  def test_filter do
    [1, 2, 3, 4, 5]
    |> MyEnum.filter(&(&1 > 3))
  end

  def test_map do
    [1, 2, 3, 4, 5]
    |> MyEnum.map(&(&1 * &1))
  end
end
