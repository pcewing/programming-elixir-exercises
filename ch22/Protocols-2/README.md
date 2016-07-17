# Exercise: Protocols-2
Using a list of words in your language, write a program to look for words where the result of calling *rot13(word)* is also a word in the list. (For various English word lists, look at [http://wordlist.sourceforge.net/]. The SCOWL collection looks promising, as it already has words divided by size.)

## Solution
See the [caesar.exs](./caesar.exs) file for the full solution.

Using SCOWL - as recommended in the problem stated - I generated a list of English words in the [words.txt](./words.txt) file. Before we start coding, let's come up with the algorithm we plan on using. I'm not going to try to optimize the runtime performance, but I want a game plan before I start the implementation.

The easiest solution I am envisioning is:
1. Read the word list from the file, storing each word as an entry in a *MapSet*.
2. Iterate through the *MapSet* and for each word, rotate the word and then check if the rotation is a member of the *MapSet*.
3. If the element is a member, append it to a list. If the element is not a member, ignore it.

Sounds simple enough. I don't know about the internal workings of the *MapSet* type but I would hope that lookups (Membership checks) are constant time. If that's the case, our algorithm will be O(n).

Let's start out by reading the file into a *MapSet*:
```
words = "words.txt"
|> File.stream!
|> Stream.map(&String.strip(&1))
|> Enum.reduce(MapSet.new, fn(word, acc) -> MapSet.put(acc, word) end)
```
Ah, Elixir is truly beautiful. In case it isn't clear what's going on, we are:
1. Opening a file stream so that we don't read the entire file at once.
2. Stripping any leading or trailing white space off of each line (lazily).
3. Reducing the list of words into a single *MapSet* containing each word. Steps 1 and 2 were both lazy, so this is the only time we actually iterate through the list!

Now that we have the list of words in memory, the next step was to iterate through each word, rotate the word, and check if the word exists in the original set. Let's do it:
```
defmodule Test do
  def test do
    words = "words.txt"
    |> File.stream!
    |> Stream.map(&String.strip(&1))
    |> Enum.reduce(MapSet.new, fn(word, acc) -> MapSet.put(acc, word) end)

    words
    |> Enum.reduce([], fn(word, acc) -> update_results(word, words, acc) end)
  end

  def rotation_exists?(word, words) do
    rotated = Encryptable.rot13(word)
    MapSet.member?(words, rotated)
  end

  def update_results(word, words, acc) do
    case rotation_exists?(word, words) do
      true -> [word | acc]
      false -> acc
    end
  end
end
```

So, first we create a simple function called *rotation_exists?*. It takes a word and a *MapSet* of words, applies ROT13 to the word, and then returns whether or not the *MapSet* of words contains the result. Next, we create a (Ambiguously named) function called *update_results*. This takes a word, a *MapSet* of words, and an accumulator. It checks if the rotation exists and adds the word to the accumulator if so.

Finally, in the *test* method, we call *Enum.reduce* using the original set of words to create a new list containing only words whose rotations exist.

Here it is in *iex*:
```
iex> Test.test
["or", "one", "rail", "be", "bar", "envy", "she", "fur"]
```

Let's check one of the results:
```
iex> Encryptable.rot13("rail")
"envy"
```
That is a word and it make sense that "envy" happens to be in the list, as its rotation should be "rail".
