load "crawl.rb"
url = "https://forums.sufficientvelocity.com/threads/marked-for-death-a-rational-naruto-quest.24481/"

quests = Dir.glob("docs/data/quests/*")

quests.each do |quest|
  id = quest.split("/").last
  download = "quests/" + id
  url = "https://forums.sufficientvelocity.com/threads/" + id + "/"
  crawl = Crawl.new()
  crawl.set_url(url)
  crawl.set_dir(download)
  crawl.auto_download()
end
