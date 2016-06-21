# Exercise: StringsAndBinaries-7
Chapter 7, *Lists and Recursion*, on page 61, had an exercise about calculating sales tax on page 104. We now have the sales information in a file of comma-separated *id*, *ship_to*, and *amount* values. The file looks like this:

```
id,ship_to,net_amount
123,:NC,100.00
124,:OK,35.50
125,:TX,24.00
126,:TX,44.80
127,:NC,25.00
128,:MA,10.00
129,:CA,102.00
120,:NC,50.00
```

Write a function that reads and parses this file and then passes the result to the *sales_tax* function. Remember that the data should be formatted into a keyword list, and that the fields need to be the correct types (so the *id* field is an integer and so on).

You'll need the library functions *File.open*, *IO.read(file, :line)*, and *IO.stream(file)*.

## Solution
See the [price_calculator.exs](./price_calculator.exs) file for the full module.

Let's start off by reading the file and parsing the orders. I believe the problem is a little dated as the *IO.read* function isn't actually necessary anymore and there is no *IO.stream/1* function. Nevertheless, after looking at the Elixir docs I was able to figure out that pretty much everything we need in order to read the file we can get from *File.open!* and *IO.stream/2*.

So, we want to open the CSV file, read each line, and strip off any leading/trailing white space. Notice that we also separate out the *header* line and ignore it since it doesn't contain any data we care about. Lastly, we take all of the lines and run another function *do_parse_order* on each one to transform each line into the data structure we want.
```
defp do_read_orders do
  file = File.open! "orders.csv"

  # Note that in Elixir 1.3 String.strip was renamed to String.trim
  [_header | lines] = Enum.map IO.stream(file, :line), &String.strip(&1)

  Enum.map lines, &do_parse_order(&1)
end
```

Given the file is in CSV format, we can break up the tokens by splitting the string on a comma. This gives us each of the string representations that then need to be converted to their correct types. The ID and net amount are simple since we can just use parse; however, there is a bit of a curve ball with the *ship_to* field because the *Atom.parse* method doesn't expect the colon character to be present. If it is, *Atom.parse* won't return what you expect: `Atom.parse ":ok" #=> :":ok"`. So, we remove the colon. Lastly, we create the *Keyword list* and return it.
```
defp do_parse_order(order) do
  [id_string, ship_to_string, net_amount_string] = String.split(order, ",")
  {id, _} = Integer.parse id_string
  ship_to = String.replace(ship_to_string, ":", "") |> String.to_atom
  {net_amount, _} = Float.parse net_amount_string
  Keyword.new([{:id, id}, {:ship_to, ship_to}, {:net_amount, net_amount}])
end
```

Now that we've parsed the file and have the list of orders in the expected format, we can just run the method we already wrote in the previous exercise:
```
  def calculate do
    do_read_orders
      |> Enum.map(fn order -> do_apply_tax(order, tax_rates) end)
  end

  # This was already written previously.
  defp do_apply_tax(order, tax_rates) do
    tax = Keyword.get(tax_rates, order[:ship_to], 0)
    Keyword.put(order, :total_amount, order[:net_amount] + order[:net_amount] * tax)
  end

  def tax_rates do
    [NC: 0.075, TX: 0.08]
  end
```

Let's test it:
```
iex> PriceCalculator.calculate
[[total_amount: 107.5, id: 123, ship_to: :NC, net_amount: 100.0],
 [total_amount: 35.5, id: 124, ship_to: :OK, net_amount: 35.5],
 [total_amount: 25.92, id: 125, ship_to: :TX, net_amount: 24.0],
 [total_amount: 48.384, id: 126, ship_to: :TX, net_amount: 44.8],
 [total_amount: 26.875, id: 127, ship_to: :NC, net_amount: 25.0],
 [total_amount: 10.0, id: 128, ship_to: :MA, net_amount: 10.0],
 [total_amount: 102.0, id: 129, ship_to: :CA, net_amount: 102.0],
 [total_amount: 53.75, id: 120, ship_to: :NC, net_amount: 50.0]]
```
