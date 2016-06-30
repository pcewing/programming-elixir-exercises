# Exercise Nodes-2
When I introduced the internal server, I said it sent a tick "about every 2 seconds." But in the receive loop, it has an explicit timeout of 2,000 ms. Why did I say "about" when it looks as if the time should be pretty accurate?

## Solution
The ticker should send a message pretty accurately every 2000ms; however, I would assume there is a certain overhead, albeit small, involved in the message being delivered to the remote node. This would be more apparent when the nodes are not both on the same machine.

(There is also probably a couple microseconds or so of overhead just making the recursive call but I would think this is negligible.)
