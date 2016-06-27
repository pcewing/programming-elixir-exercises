# Exercise: OrganizingAProject-6
In the United States, the National Oceanic and Atmospheric Administration provides hourly XML feeds of conditions at 1,800 locations. For example, the feed for a small airport close to where I'm writing this is at *http://w1.weather.gov/xml/current_obs/KDTO.xml*.

Write an application that fetches this data, parses it, and displays it in a nice format.

(Hint: You might not have to download a library to handle XML parsing.)

## Solution
See the [weather](./weather) directory for the solution. Here it is run in *iex*:

I could have used Erlang's *xmerl* library but chose to use *SweetXml* instead; it's a nice little wrapper for it.

```
iex> Weather.check
Weather at Denton Municipal Airport, TX
---------------------------------------
Time: 4:53 pm CDT
Temperature: 92.0° F
Winds: 12.7 MPH to the South
```
