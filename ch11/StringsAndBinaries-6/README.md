# Exercise: StringsAndBinaries-6
Write a function to capitalize the sentences in a string. Each sentence is terminated by a period and a string. Right now, the case of the characters in the string is random.

## Solution
See the [sentences.exs](./sentences.exs) file for the full module.

They gave us a pretty big hint by telling us each sentence is terminated by a period and a string; now we know what we can split on. Let's start there:
```
defp do_separate_sentences(paragraph) do
  sentences = String.split(paragraph, ". ")
end
```

The only problem with this is that by splitting on ". ", we lose those characters so we need to append a period to all but the last sentence.
```
defp do_separate_sentences(paragraph) do
  sentences = String.split(paragraph, ". ")
  Enum.map sentences, fn sentence ->
    case String.ends_with?(sentence, ".") do
      false -> sentence <> "."
      true -> sentence
    end
  end
end
```
Okay, now we have separated out the sentences so we can move on to capitalization. The *String* module provides this for us so all we need to do is:
```
defp do_capitalize(sentences) do
  Enum.map sentences, fn sentence -> String.capitalize sentence end
end
```
And finally, we need to bring the sentences back together again:
```
defp do_join_sentences(sentences) do
  Enum.join sentences, " "
end
```

Put it all together:
```
def capitalize(paragraph) do
  paragraph
  |> do_separate_sentences
  |> do_capitalize
  |> do_join_sentences
end
```

Let's test it:
```
iex> Sentences.capitalize "oh. a DOG. woof."
"Oh. A dog. Woof."
```
