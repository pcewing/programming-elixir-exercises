# Exercise: Protocols-3
Collections that implement the *Enumerable* protocol define *count*, *member?*, and *reduce* functions. The *Enum* module uses these to implement methods such as *each*, *filter*, and *map*.

Implement your own versions of *each*, *filter*, and *map* in terms of reduce.

## Solution
See the [my_enum.exs](./my_enum.exs) file for the full solution.

Let's start with *each*. We actually won't be reducing the enumerable at all. All we care about is running a function on each element and returning *:ok*. Here's what that looks like:
```
def each(enumerable, fun) do
  reducer = fn(elem, _acc) ->
    fun.(elem)
    {:cont, nil}
  end

  enumerable
  |> Enumerable.reduce({:cont, nil}, reducer)

  :ok
end
```
The accumulator doesn't really matter, apart from the *:cont* atom which tells *reduce* to continue iterating, so we can just set it to and leave it as *nil*. Our reducer just runs the function that was provided on the element and at the end we return *:ok*.

Next let's look at filter. This one is a little less intuitive as we aren't really filtering the enumerable. We are actually just constructing a new list and adding only the elements that meet the condition defined by the provided function:
```
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
```
So, the *reducer* just prepends or ignores each element based on the result of the provided function. At the end we reverse the result to put the list back into its original order. (I cheated a little bit by using the *Enum.reverse* function but the problem statement wasn't to write that ourself.)

Finally, let's look at map. This one is simpler than *filter* in my opinion; it's practically the same logic except we don't care about the provided function's return value. Instead, we just always prepend the result to the resulting list:
```
def map(enumerable, fun) do
  reducer = fn(elem, acc) ->
    {:cont, [fun.(elem) | acc]}
  end

  {:done, result} = enumerable
  |> Enumerable.reduce({:cont, []}, reducer)

  result
  |> Enum.reverse
end
```

Let's test our implementation using the following module:
```
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
```

In *iex*:
```
iex> Test.test_each
1
2
3
4
5
:ok
iex> Test.test_filter
[4, 5]
iex> Test.test_map   
[1, 4, 9, 16, 25]
```

Looks good!
