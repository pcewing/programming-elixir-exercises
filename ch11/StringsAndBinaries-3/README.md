# Exercise: StringsAndBinaries-3
Try the following in iex:
```
iex> ['cat' | 'dog']
['cat', 100, 111, 103]
```

## Solution
When using the `[head | tail]` operator, *head* is a single element whereas *tail* is the list of remaining elements. So, when we say ['ab' | 'cd'], the first *element* of the list becomes the sublist 'ab'. This is the same as saying:
```
[[99, 97, 116], 100, 111, 103]
```
