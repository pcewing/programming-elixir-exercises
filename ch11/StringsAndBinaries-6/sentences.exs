defmodule Sentences do
  def capitalize(paragraph) do
    paragraph
    |> do_separate_sentences
    |> do_capitalize
    |> do_join_sentences
  end

  defp do_separate_sentences(paragraph) do
    sentences = String.split(paragraph, ". ")
    Enum.map sentences, fn sentence ->
      case String.ends_with?(sentence, ".") do
        false -> sentence <> "."
        true -> sentence
      end
    end
  end

  defp do_capitalize(sentences) do
    Enum.map sentences, fn sentence -> String.capitalize sentence end
  end

  defp do_join_sentences(sentences) do
    Enum.join sentences, " "
  end
end
