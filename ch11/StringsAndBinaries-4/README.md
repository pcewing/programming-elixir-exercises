# Exercise: StringsAndBinaries-4
(Hard) Write a function that takes a single-quoted string of the form *number* [+-*/] *number* and returns the result of the calculation. The individual numbers do not have leading plus or minus signs.

## Solution
See the [calculator.exs](./calculator.exs) file for the full module.

The first order of business is to split up the three tokens. We can do this pretty easily by converted the char list to a string and using the *String.split* function on a space. Once we have the three tokens, we should use the Float module to parse the first and third token into a float.

Finally, once we have the float representation of the numbers we are calculating, we can simply check which operation was passed in an apply it to the two numbers.

```
def calculate(equation) when is_list(equation) do
  [num1_string, op_string, num2_string] =
    List.to_string(equation)
    |> String.split(" ")

  {num1, _} = Float.parse(num1_string)
  {num2, _} = Float.parse(num2_string)
  case op_string do
    "+" -> num1 + num2
    "-" -> num1 - num2
    "*" -> num1 * num2
    "/" -> num1 / num2
  end
end
```

That wasn't so bad! Let's test that it works:
```
iex> Calculator.calculate '12 + 3'
15.0
iex> Calculator.calculate '14.5 - 12'
2.5
iex> Calculator.calculate '1623 * 0.5'
811.5
iex> Calculator.calculate '36 / 12'   
3.0
```
