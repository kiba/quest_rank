require "json"
require "byebug"

# Download a specific target.
argument = ARGV[0]

if !argument.nil?
  targets = [ARGV[0].to_i]
else
  targets = []
  lists = Dir["./docs/quests/*"]
  lists.each do |e|
    targets.push(e.split("/").last.split(".").first.to_i)
  end
end

def get_dates target
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
  return dates
end

def biggest dates
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
end


targets.each do |t|
  dates = get_dates(t)
  puts " "
  puts " Quest " + t.to_s
  puts " " + ("=" * 10)
  biggest(dates)
  posting_frequency = dates.to_a.to_json
  File.open("./docs/data/quests/#{t}/date-posts-frequency.json","w") do |f|
    f.write(posting_frequency)
    f.close()
  end
end
