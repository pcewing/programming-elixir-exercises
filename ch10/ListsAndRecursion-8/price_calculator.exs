defmodule PriceCalculator do
  def calculate(tax_rates, orders) do
    orders
      |> Enum.map(fn order -> do_apply_tax(order, tax_rates) end)
  end

  def do_apply_tax(order, tax_rates) do
    tax = Keyword.get(tax_rates, order[:ship_to], 0)
    Keyword.put(order, :total_amount, order[:net_amount] + order[:net_amount] * tax)
  end

  def orders do
    [
      [id: 123, ship_to: :NC, net_amount: 100.00],
      [id: 124, ship_to: :OK, net_amount: 35.50],
      [id: 125, ship_to: :TX, net_amount: 24.00],
      [id: 126, ship_to: :TX, net_amount: 44.00],
      [id: 127, ship_to: :NC, net_amount: 25.00],
      [id: 128, ship_to: :MA, net_amount: 10.00],
      [id: 129, ship_to: :CA, net_amount: 102.00],
      [id: 120, ship_to: :NC, net_amount: 50.00]
    ]
  end

  def tax_rates do
    [NC: 0.075, TX: 0.08]
  end
end
