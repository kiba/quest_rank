load "./src/lib/crawl.rb"
require"byebug"

if ARGV.size > 0
  quests = ["../docs/data/quests/" + ARGV[0]]
else
  quests = Dir.glob("./docs/data/quests/*")
end

crawl = Crawl.new()

quests.each do |quest|
  id = quest.split("/").last
  download = "quests/" + id
  puts "Crawling thread: " + id
  url = "https://forums.sufficientvelocity.com/threads/" + id + "/"
  crawl.set_url(url)
  crawl.set_dir(download)
  crawl.auto_download()
end
