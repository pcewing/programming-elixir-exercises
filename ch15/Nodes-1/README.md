# Exercise Nodes-1
Set up two terminal windows, and go to a different directory in each. Then start up a named node in each. In one window, write a function that lists the contents of the current directory.

```
fun = fn -> IO.puts(Enum.join(File.ls!, ",")) end
```

Run it twice, once on each node.

## Solution
This isn't really a solution, but here's what the two executions look like. This is all we do in the first terminal:
```
me@my-pc:~/dev/spokes/client$ iex --sname node_one
iex(node_one@my-pc)> Node.self
:"node_one@my-pc"
```

In the second, we connect to the first, define the function, and then call it both locally and on the remote node.
```
iex(node_two@my-pc)> Node.connect :"node_one@my-pc"
true
iex(node_two@my-pc)> Node.list
[:"node_one@my-pc"]
iex(node_two@my-pc)> fun = fn -> IO.puts(Enum.join(File.ls!, ",")) end
#Function<20.52032458/0 in :erl_eval.expr/5>
iex(node_two@my-pc)> fun.()
.git,.editorconfig,.gitignore,index.js,node_modules,lib,README.md,LICENSE,gulpfile.js,test,package.json
:ok
iex(node_two@my-pc)> Node.spawn(:"node_one@my-pc", fun)
.git,.editorconfig,.gitignore,config,.babelrc,README.md,LICENSE,tasks,gulpfile.js,resources,erl_crash.dump,app,package.json
#PID<8904.93.0>
iex(node_two@my-pc)>
```
