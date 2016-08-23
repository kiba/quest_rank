require "json"

file = File.read("doc/data.json")

data = JSON.parse(file)

dates = {}



data.each do |d|
  d = JSON.parse(d)
  key = d["date"]
  if dates.key?(key) == true
    dates[key] += 1
  else
    dates.merge!({key => 1})
  end
end
puts dates
