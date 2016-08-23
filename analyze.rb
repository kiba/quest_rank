require "json"

file = File.read("doc/data.json")

data = JSON.parse(file)

dates = {}

element = JSON.parse(data[0])

if dates.key?(element["date"]) == true
  dates[element["date"]] += 1
else
  dates.merge!({element["date"] => 1})
end

puts dates
