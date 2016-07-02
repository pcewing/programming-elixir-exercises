# Exercise: Functions-5
Use the &... notation to rewrite the following.
```
Enum.map [1, 2, 3, 4], fn x -> x + 2 end
Enum.each [1, 2, 3, 4], fn x -> IO.inspect x end
```

## Solution
There isn't much to this one. First, let's replace the *fn x -> ... end* with:
```
&(...)  
```

The function takes one parameter, which we can reference using *&1*, and then we just need to add *2* to it.
```
&(&1 + 2)
```

Plug that back in and we get:
```
Enum.map [1, 2, 3, 4], &(&1 + 2)
```

Let's do the same thing for the second line:
```
Enum.each [1, 2, 3, 4], &(IO.inspect &1)
```

And now, let's test it:
```
iex> Enum.map [1, 2, 3, 4], fn x -> x + 2 end  
[3, 4, 5, 6]  
iex> Enum.map [1, 2, 3, 4], &(&1 + 2)  
[3, 4, 5, 6]  

iex> Enum.each [1, 2, 3, 4], fn x -> IO.inspect x end  
1  
2  
3  
4  
:ok  
iex> Enum.each [1, 2, 3, 4], &(IO.inspect &1)  
1  
2  
3  
4  
:ok  
```
