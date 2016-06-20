defmodule Calculator do
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
end
