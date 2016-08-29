require "json"
require "byebug"

file = File.read("docs/data.json")

data = JSON.parse(file)

dates = {}


data.each do |d|
  d = JSON.parse(d)
  key = d["date"]
  if key == ""
    raise "ERROR! Key is blank."
  end
  if dates.key?(key) == true
    dates[key] += 1
  else
    dates.merge!({key => 1})
  end
end

dates.to_a

biggest = {:date => nil, :count => 0}
records = []

dates.each do |d|
  if d[1] > biggest[:count]
    biggest[:date] = d[0]
    biggest[:count] = d[1]
    records.push({:date => d[0], :count => d[1]})
  end
end

puts records

content = dates.to_json


File.open("docs/post-frequency.json","w") do |f|
  f.write(content)
end
