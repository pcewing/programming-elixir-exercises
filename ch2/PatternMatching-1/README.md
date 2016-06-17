# Exercise: PatternMatching-1
Which of the following will match?
```
a = [1, 2, 3]         # Yes, a => [1, 2, 3]
a = 4                 # Yes, a => 4
4 = a                 # Yes
[a, b] = [1, 2, 3]    # No
a = [[1, 2, 3]]       # Yes, a => [[1, 2, 3]]
[a] = [[1, 2, 3]]     # Yes, a => [1, 2, 3]
[[a]] = [[1, 2, 3]]   # No
```
