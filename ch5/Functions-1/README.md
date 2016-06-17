# Exercise: Functions-1
Go into iex. Create and run the functions that do the following:

```
list_concat.([:a, :b], [:c, :d]) # => [:a, :b, :c, :d]  
sum.(1, 2, 3) # => 6  
pair_tuple_to_list.({1234, 5678}) # => [1234, 5678]  
```

## Solution

```
iex> list_concat = fn list_a, list_b -> list_a ++ list_b end  
#Function<12.50752066/2 in :erl_eval.expr/5>  
iex> list_concat.([:a, :b], [:c, :d])  
[:a, :b, :c, :d]  

iex> sum = fn num_a, num_b, num_c -> num_a + num_b + num_c end  
#Function<18.50752066/3 in :erl_eval.expr/5>  
iex> sum.(1, 2, 3)  
6  

iex> pair_tuple_to_list = fn {a, b} -> [a, b] end  
#Function<6.50752066/1 in :erl_eval.expr/5>  
iex> pair_tuple_to_list.({1234, 5678})  
[1234, 5678]  
```
