# Exercise: ModulesAndFunctions-7
Find the library functions to do the following, and then use each in *iex*. (If the word *Elixir* or *Erlang* appears at the end of the challenge, then you'll find the answer in that set of libraries.)

- Convert a float to a string with two decimal digits. (*Erlang*)
- Get the value of an operating-system environment variable. (*Elixir*)
- Return the extension component of a file name (so return .exs if given "dave/test.exs"). (*Elixir*)
- Return the process's current working directory. (*Elixir*)
- Convert a string containing JSON into Elixir's data structures. (Just find; don't install.)
- Execute a command in your operating system's shell.

## Solutions

### Float Conversion
The problem ends with *Erlang* so let's look at the Erlang docs. In *io* there is a method called format, but this alone doesn't look like what we want as it's coupled closely with *fwrite*. However, in *io_lib* I also see a *format* method which looks more promising; this one just returns a character list. Let's try it:
```
iex> print_float = fn n -> :io_lib.format("~.2f", [n]) end  
#Function<6.50752066/1 in :erl_eval.expr/5>  
iex> print_float.(2.123)  
['2.12']  
```

Almost got it, except it returned a list of strings instead of just the string. I believe this is because the data parameter we passed in was a list. Anyways, let's just take the head:
```
iex> print_float = fn n ->  
...>   [head | _] = :io_lib.format("~.2f", [n])  
...>   head  
...> end  
#Function<6.50752066/1 in :erl_eval.expr/5>  
iex> print_float.(2.123)  
'2.12'  
iex> print_float.(273.1834)  
'273.18'  
```

### Environment Variable
A quick Google search of "Elixir Environment Variable" brought me to the System module in the Elixir docs and *get_env* looks promising. Let's try it:
```
iex> System.get_env "SHELL"  
"/bin/bash"  
```

### File Extensions
So I immediately look in the *File* and *File.Stat* modules thinking those were likely places for this, but after no success, a search in the docs led me to *Path*, where an *extname* function resides:
```
$ touch ~/test.txt
$ iex
iex> Path.extname("~/test.txt")
".txt"
```

### Process CWD
Again, I thought I new exactly where this one would be: *Process*. But, a quick search again led me to the right place: *File*. It has the function *cwd*:
```
iex> File.cwd
{:ok, "/home/paul/dev/programming-elixir-exercises"}
```

### JSON Deserialization
Ironically, working on a side project I already did this using a library I found on Github called *Poison*. See it here:
https://github.com/devinus/poison

# OS Shell Execution
Looking in the Elixir docs again, *System.cmd* looks like it should work:
```
iex> System.cmd "echo", ["Hello world"]
{"Hello world\n", 0}
```

Righteous.
