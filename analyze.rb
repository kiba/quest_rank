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

content = dates.to_a.to_json


File.open("docs/post-frequency.json","w") do |f|
  f.write(content)
end
