# Exercise: OrganizingAProject-3
Bring your version of this project in line with the code here.

## Solution
See the [issues](./issues) directory for the mix project containing the solution.

I'm not going to explain much as we're pretty much just filling in what is laid out in the chapter. One notable difference is the definition of the `Issues.GithubIssues.handle_response` method. We actually need to match on tuple; I'm guessing this was changed in a later version of *HTTPoison*.
