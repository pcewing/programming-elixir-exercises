# Exercise: ControlFlow-2
We now have three different implementations of FizzBuzz. One uses *cond*, one uses *case*, and one uses separate functions with guard clauses.

Take a minute to look at all three. Which do you feel best expresses the problem? Which will be easiest to maintain?

The *case* style and the implementation using guard clauses are different from control structures in most other languages. If you feel that one of these was the best implementation, can you think of ways to remind yourself to investigate these options as you write Elixir code in the future?

## Solution
I definitely think that the implementation using separate functions and guard clauses feels the cleanest and easiest to maintain. It would be trivial to modify one of the cases without even touching any of the others' implementations.

I don't think I will need a way to remember; it always to to use mechanisms that make the most sense for the task I am trying to accomplish. Granted I am more used to OOP control flow, I will probably just always consider guard clauses first and ask myself if they make sense. In the off chance that they make the task more complicated, then perhaps it makes sense to go with something else.
