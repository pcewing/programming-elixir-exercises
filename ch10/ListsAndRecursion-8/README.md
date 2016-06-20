# Exercise: ListsAndRecursion-8
The Pragmatic Bookshelf has offices in Texas (TX) and North Carolina (NC), so we have to charge sales tax on orders shipped to these states. The rates can be expressed as a keyword list:
```
tax_rates = [NC: 0.075, TX: 0.08]
```
Here's a list of orders:
```
orders = [
  [id: 123, ship_to: :NC, net_amount: 100.00],
  [id: 124, ship_to: :OK, net_amount: 35.50],
  [id: 125, ship_to: :TX, net_amount: 24.00],
  [id: 126, ship_to: :TX, net_amount: 44.00],
  [id: 127, ship_to: :NC, net_amount: 25.00],
  [id: 128, ship_to: :MA, net_amount: 10.00],
  [id: 129, ship_to: :CA, net_amount: 102.00],
  [id: 120, ship_to: :NC, net_amount: 50.00]
]
```
Write a function that takes both lists and returns a copy of the orders, but with an extra field, total_amount, which is the net plus sales tax. If a shipment is not to NC or TX, there's no tax applied.

## Solution
See the [price_calculator.exs](./price_calculator.exs) file for the full module.

Where do we start? Well, we know that we are going to take the collection of orders, apply a function to each order, and return a new collection which is the result of each operation. That's an immediate hint that we will probably want to use *Enum.map*. So, the next question is, what do we do to each order?

For each order, we are going to look at the value of *:ship_to*, and then we will cross-reference it with the value in the tax rates. If a tax rate exists for the state, we will apply it, otherwise we will just set the total amount to the net amount. Let's write a helper function called *do_apply_tax* to make our lives easier. Given an order, it will check for a tax rate and then return the order with the total_amount field.
```
defp do_apply_tax(tax_rates, order) do
  tax = Keyword.get(tax_rates, order[:ship_to], 0)
  Keyword.put(order, :total_amount, order[:net_amount] + order[:net_amount] * tax)
end
```

The *Keyword.get* function gives us the option of specifying a default value if the key is not found, so anything other than *:NC* and *:TX* will simply return a tax rate of 0. Then, we return the order with the new field added.

Now, let's run it accross all of the orders:
```
def calculate(tax_rates, orders) do
  orders
    |> Enum.map(fn order -> do_apply_tax(order, tax_rates) end)
end
```

Let's test it:
```
iex> tax_rates
[NC: 0.075, TX: 0.08]
iex> orders
[[id: 123, ship_to: :NC, net_amount: 100.0],
 [id: 124, ship_to: :OK, net_amount: 35.5],
 [id: 125, ship_to: :TX, net_amount: 24.0],
 [id: 126, ship_to: :TX, net_amount: 44.0],
 [id: 127, ship_to: :NC, net_amount: 25.0],
 [id: 128, ship_to: :MA, net_amount: 10.0],
 [id: 129, ship_to: :CA, net_amount: 102.0],
 [id: 120, ship_to: :NC, net_amount: 50.0]]
iex> PriceCalculator.calculate(tax_rates, orders)
[[total_amount: 107.5, id: 123, ship_to: :NC, net_amount: 100.0],
 [total_amount: 35.5, id: 124, ship_to: :OK, net_amount: 35.5],
 [total_amount: 25.92, id: 125, ship_to: :TX, net_amount: 24.0],
 [total_amount: 47.52, id: 126, ship_to: :TX, net_amount: 44.0],
 [total_amount: 26.875, id: 127, ship_to: :NC, net_amount: 25.0],
 [total_amount: 10.0, id: 128, ship_to: :MA, net_amount: 10.0],
 [total_amount: 102.0, id: 129, ship_to: :CA, net_amount: 102.0],
 [total_amount: 53.75, id: 120, ship_to: :NC, net_amount: 50.0]]
```

Wow.
