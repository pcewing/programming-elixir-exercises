defmodule ServerTest do
  use ExUnit.Case

  test "popping retrieves an item from the stack" do
    top = Stack.Server.pop
    assert top == 1
  end

  test "pushing adds an item to the stack" do
    Stack.Server.push(25)
    top = Stack.Server.pop
    assert top == 25
  end
end
