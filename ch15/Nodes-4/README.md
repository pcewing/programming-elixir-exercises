# Exercise Nodes-4
The ticker process in this chapter is a central server that sends events to registered clients. Reimplement this as a ring of clients. A client sends a tick to the next client in the ring. After 2 seconds, *that* client sends a tick to its next client.

When thinking about how to add clients to the ring, remember to deal with the case where a client's receive loop times out just as you're adding a new process. What does this say about who has to be responsible for updating the links?

## Solution
See the [ticker.exs](./ticker.exs) file for the full module.

I'm implementing this using the idea of leaders and followers. The first client to register declares itself the leader. The leader is responsible for listening for registration requests from other clients as well as emitting the tick message to the next client in the chain. When the leader is the only one in the chain, it simply prints tick and continues being the leader.

When the leader is not the only one in the chain, it will increment the index of the next leader, unregister its name globally, and then send the tick message along with the state to the next leader.

The follower who receives the tick message will declare itself the leader by registering the leader name. It then takes on the leadership responsibilities previously mentioned.

This is the initial client. You can see that until another client registers it simply ticks.
```
$ iex --sname a ticker.exs
iex(a@my-pc)> Ticker.register
tick
tick
tick
registering #PID<12364.92.0>
tick
tock in client
tick
tock in client
tick
tock in client
tick
tock in client
tick
tock in client
tick
```

When the second client registers, the two begin to tick tock, passing leadership back and forth.
```
$ iex --sname b ticker.exs
iex(b@my-pc)> Node.connect(:"a@my-pc")
true
iex(b@my-pc)> Ticker.register
tock in client
tick
tock in client
tick
tock in client
registering #PID<12409.92.0>
tick
tock in client
tick
tock in client
tick
tock in client
tick
tock in client
```

When the third client registers, it becomes a circle with the leadership being passed around.
```
$ iex --sname c ticker.exs
iex(c@my-pc)> Node.connect(:"a@my-pc")
true
iex(c@my-pc)> Ticker.register
tock in client
tick
tock in client
tick
tock in client
tick
```

There is definitely a race condition in this implementation, When the current leader unregisters its name, the new leader won't register the name until it has received the message. A new client could register in this time and take the leadership, effectively breaking the existing chain because the process won't be able to register the name.

I'm not sure if there is a good way around this without adding some sort of centralization mechanism.
