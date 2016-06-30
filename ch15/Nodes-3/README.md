# Exercise Nodes-3
Alter the code so that successive ticks are sent to each registered client (so the first goes to the first client, the second to the next client, and so on). Once the last client receives a tick, the process starts back at the first. The solution should deal with new clients being added at any time.

## Solution
See the [ticker.exs](./ticker.exs) file for the full module.

To test this, I ran four terminals. The first was the server and the other three were the clients. The server waited for the client nodes to each connect and then listed the nodes it was aware of. Once all of the nodes were connected, the server started ticking.
```
$ iex --sname server ticker.exs
iex(server@my-pc)> Node.list
[:"client_c@my-pc", :"client_b@my-pc", :"client_a@my-pc"]
iex(server@my-pc)> Ticker.Server.start
:yes
tick                  
tick                  
registering #PID<12403.116.0>
tick                  
tick                  
registering #PID<12402.116.0>
tick                  
tick                  
tick                  
registering #PID<12401.116.0>
tick                  
tick                  
tick                  
tick                  
tick                  
tick                  
tick                  
tick                  
tick                  
```

When the first client registers, it is the only one receiving messages.
```
$ iex --sname client_a ticker.exs
iex(client_a@my-pc)> Node.connect(:"server@my-pc")
true
iex(client_a@my-pc)> Ticker.Client.start
{:register, #PID<0.116.0>}
tock in client          
tock in client          
tock in client          
tock in client          
tock in client          
tock in client          
```

Once the second client registers, the ticks received are alternated between client a and b.
```
$ iex --sname client_b ticker.exs
iex(client_b@my-pc)> Node.connect(:"server@my-pc")
true
iex(client_b@my-pc)> Ticker.Client.start
{:register, #PID<0.116.0>}
tock in client          
tock in client          
tock in client          
tock in client          
tock in client          
```

Finally, once the third client registers, the ticks cycle through the three clients.
```
$ iex --sname client_c ticker.exs
iex(client_c@my-pc)> Node.connect(:"server@my-pc")
true
iex(client_c@my-pc)> Ticker.Client.start
{:register, #PID<0.116.0>}
tock in client          
tock in client          
tock in client          
```

The one interesting thing I hadn't thought about is this implementation actually cycles through the clients in the reverse order. This is because we are actually adding each new client to the front of the list but we iterate from front to back. We could easily fix this by changing the *current* logic to decrement instead of increment but I decided to just leave it because it doesn't really matter.
