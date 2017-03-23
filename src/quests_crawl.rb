load "./src/lib/crawl.rb"
require"byebug"

if ARGV.size > 0
  quests = ["../docs/data/quests/" + ARGV[0]]
  progress = 0
else
  quests = Dir.glob("../docs/data/quests/*")
  file = File.open("progress.txt","r")
  progress = file.readline().to_i
  file.close()
end

progress.times do
  quests.shift()
end

puts quests

crawl = Crawl.new()

quests.each do |quest|
  id = quest.split("/").last
  download = "quests/" + id
  puts "Crawling thread: " + id
  url = "https://forums.sufficientvelocity.com/threads/" + id + "/"
  crawl.set_url(url)
  crawl.set_dir(download)
  crawl.auto_download()
  progress += 1
  File.open("../progress.txt","w") do |f|
    f.write(progress)
  end
end
