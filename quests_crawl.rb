load "crawl.rb"
url = "https://forums.sufficientvelocity.com/threads/marked-for-death-a-rational-naruto-quest.24481/"

quests = Dir.glob("docs/data/quests/*")

file = File.open("progress.txt","r")
progress = file.read[0].to_i
file.close()

quests.each do |quest|
  id = quest.split("/").last
  download = "quests/" + id
  puts "Crawling thread: " + id
  url = "https://forums.sufficientvelocity.com/threads/" + id + "/"
  crawl = Crawl.new()
  crawl.set_url(url)
  crawl.set_dir(download)
  crawl.auto_download()
end
