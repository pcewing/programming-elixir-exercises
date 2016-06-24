defmodule Weather do
  @url Application.get_env(:weather, :url)

  import SweetXml

  def check do
    HTTPoison.get(@url, [])
    |> handle_response
    |> print
  end

  def handle_response({:ok, %{status_code: 200, body: body}}), do: deserialize(body)
  def handle_response({:ok, %{status_code: code}}), do: {:error, {"Bad status code: #{code}"}}
  def handle_response({:error, error}), do: {:error, error}

  def deserialize(xml) do
    location = xml |> xpath(~x"//location/text()") |> List.to_string
    datetime = xml |> xpath(~x"//observation_time/text()") |> List.to_string
    [_date, time] = String.split(datetime, ", ")
    temp = xml |> xpath(~x"//temp_f/text()") |> List.to_string
    wind_dir = xml |> xpath(~x"//wind_dir/text()") |> List.to_string
    wind_mph = xml |> xpath(~x"//wind_mph/text()") |> List.to_string
    %{location: location, time: time, temp: temp, wind_dir: wind_dir, wind_mph: wind_mph}
  end

  def print(data) do
    header = "Weather at #{data.location}"
    IO.puts header
    IO.puts String.duplicate("-", String.length(header))
    IO.puts "Time: #{data.time}"
    IO.puts "Temperature: #{data.temp}° F"
    IO.puts "Winds: #{data.wind_mph} MPH to the #{data.wind_dir}"
  end
end
