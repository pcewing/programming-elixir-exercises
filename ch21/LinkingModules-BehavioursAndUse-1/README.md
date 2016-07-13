# Exercise: LinkingModules-BehavioursAndUse-1
In the body of the *def* macro, there's a quote block that defines the actual method. It contains
```
IO.puts "==> call:   #{Tracer.dump_definition(unquote(name), unquote(args))}"
result = unquote(content)
IO.puts "<== result: #{result}"
```
Why does the first call to puts have to unquote the values in its interpolation but the second call does not?

## Solution
The first call has to unquote the values because they were passed in to the macro and they need to be evaluated. The second call does not because the variable named result was actually given a value on the line prior and thus in the interpolation that variable exists as is.
