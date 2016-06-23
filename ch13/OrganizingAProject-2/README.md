# Exercise: OrganizingAProject-2
Add the dependency to your project and install it.

## Solution
See the `./issues` directory for the mix project containing the solution.

This change specifically was adding the following dependency to the *mix.exs* file:
```
{:httpoison, "~> 0.8.3"}
```

We then install the dependency by running:
```
mix deps.get
```
