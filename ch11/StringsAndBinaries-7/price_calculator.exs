defmodule PriceCalculator do
  def calculate do
    do_read_orders
      |> Enum.map(fn order -> do_apply_tax(order, tax_rates) end)
  end

  defp do_read_orders do
    file = File.open! "orders.csv"

    # Note that in Elixir 1.3 String.strip was renamed to String.trim
    [_header | lines] = Enum.map IO.stream(file, :line), &String.strip(&1)

    Enum.map lines, &do_parse_order(&1)
  end

  defp do_parse_order(order) do
    [id_string, ship_to_string, net_amount_string] = String.split(order, ",")
    {id, _} = Integer.parse id_string
    ship_to = String.replace(ship_to_string, ":", "") |> String.to_atom
    {net_amount, _} = Float.parse net_amount_string
    Keyword.new([{:id, id}, {:ship_to, ship_to}, {:net_amount, net_amount}])
  end

  defp do_apply_tax(order, tax_rates) do
    tax = Keyword.get(tax_rates, order[:ship_to], 0)
    Keyword.put(order, :total_amount, order[:net_amount] + order[:net_amount] * tax)
  end

  def tax_rates do
    [NC: 0.075, TX: 0.08]
  end
end
