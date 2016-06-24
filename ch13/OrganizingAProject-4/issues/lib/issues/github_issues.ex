defmodule Issues.GithubIssues do
  @user_agent [ {"User-agent", "Elixir pcewing00@gmail.com"} ]
  @github_url Application.get_env(:issues, :github_url)

  def fetch(user, project) do
    issues_url(user, project)
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end
  def issues_url(user, project) do
    "#{@github_url}/repos/#{user}/#{project}/issues"
  end
  def handle_response({:ok, %{status_code: 200, body: body}}) do
    {:ok, :jsx.decode(body)}
  end
  def handle_response({:ok, %{status_code: _, body: body}}) do
    {:error, :jsx.decode(body)}
  end
end
