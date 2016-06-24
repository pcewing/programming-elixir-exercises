defmodule Issues.Formatter do
  def format(issues) do
    issues
    |> filter
    |> print
  end

  def filter(issues) do
    Enum.map issues,
      fn issue ->
        created_at = HashDict.get(issue, "created_at")
        number = HashDict.get(issue, "number")
        title = HashDict.get(issue, "title")
        %{created_at: created_at, number: number, title: title}
      end
  end

  def print(issues) do
    max_num_length = get_max_num_length(issues)
    max_created_at_length = get_max_created_at_length(issues)
    max_title_length = get_max_title_length(issues)

    num_header = "#"
    length_diff = max_num_length - String.length(num_header)
    num_header = " #{num_header}#{String.duplicate(" ", length_diff)} "

    created_at_header = "created_at"
    length_diff = max_created_at_length - String.length(created_at_header)
    created_at_header = " #{created_at_header}#{String.duplicate(" ", length_diff)} "

    title_header = "title"
    length_diff = max_title_length - String.length(title_header)
    title_header = " #{title_header}#{String.duplicate(" ", length_diff)} "

    IO.puts "#{num_header}|#{created_at_header}|#{title_header}"
    IO.puts "#{String.duplicate("-", max_num_length + 2)}+#{String.duplicate("-", max_created_at_length + 2)}+#{String.duplicate("-", max_title_length + 2)}"

    Enum.each issues,
      fn issue ->
        num_string = Integer.to_string(issue.number)
        num_length_diff = max_num_length - String.length(num_string)
        number = " #{num_string}#{String.duplicate(" ", num_length_diff)} "

        created_at_length_diff = max_created_at_length - String.length(issue.created_at)
        created_at = " #{issue.created_at}#{String.duplicate(" ", created_at_length_diff)} "

        title_length_diff = max_title_length - String.length(issue.title)
        title = " #{issue.title}#{String.duplicate(" ", title_length_diff)} "

        IO.puts "#{number}|#{created_at}|#{title}"
      end
  end

  def get_max_num_length(issues) do
    issue = Enum.max_by issues,
      fn issue ->
        Integer.to_string(issue.number)
        |> String.length
      end
    Integer.to_string(issue.number)
    |> String.length
  end

  def get_max_created_at_length(issues) do
    issue = Enum.max_by issues,
      fn issue ->
        String.length(issue.created_at)
      end
    String.length(issue.created_at)
  end

  def get_max_title_length(issues) do
    issue = Enum.max_by issues,
      fn issue ->
        String.length(issue.title)
      end
    String.length(issue.title)
  end
end
