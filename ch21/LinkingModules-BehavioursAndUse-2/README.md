# Exercise: LinkingModules-BehavioursAndUse-2
The built-in  function IO.ANSI.escape will insert ANSI escape sequences in a string. If you put the resulting strings into a terminal, you can a dd colors and bold or underlined text. Explore the library, and then use it to colorize our tracing's output.

## Solution
See the [colorize.exs](./colorize.exs) file for the full module.

I've looked through the 1.1, 1.2, and 1.3 docs and IO.ANSI definitely doesn't have an *escape* function; however, the module does contain a number of other coloration functions so I will use those instead.

Lets make the calls blue and the results green:
```
IO.puts "#{IO.ANSI.blue}==> call:   #{Tracer.dump_defn(unquote(name), unquote(args))}"
result = unquote(content)
IO.puts "#{IO.ANSI.green}<== result: #{result}"
```

I doubt colors will show up in markdown but it works!
