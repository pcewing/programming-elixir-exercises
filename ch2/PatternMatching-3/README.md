# Exercise: PatternMatching-3
If you assume the variable *a* initially contains the value 2, which of the following will match?
```
[a, b, a] = [1, 2, 3] # No, a already assigned 1
[a, b, a] = [1, 1, 2] # No, a already assigned 1
a = 1                 # Yes, a => 1
^a = 2                # No, a was just assigned 1. It is pinned so it isn't reassigned 2.
^a = 1                # Yes
^a = 2 - a            # Yes, 1 = 2 - 1
```
