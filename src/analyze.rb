require "json"
require "byebug"

start = Time.now()

def eclipsed start, message
  puts message
  stop = Time.now()
  puts "Time has passed: " + ((stop - start) / 1000)
end

target = ARGV[0]

if target.empty?
  target = 24481
end

file = File.read("./docs/data/quests/#{target}/data.json")

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

biggest = {:date => nil, :count => 0}
records = []

dates.to_a.each do |d|
  if d[1] > biggest[:count]
    biggest[:date] = d[0]
    biggest[:count] = d[1]
    records.push({:date => d[0], :count => d[1]})
  end
end

puts records

posting_frequency = dates.to_a.to_json

File.open("./docs/data/quests/#{target}/date-posts-frequency.json","w") do |f|
  f.write(posting_frequency)
end
