load "crawl.rb"
url = "https://forums.sufficientvelocity.com/threads/marked-for-death-a-rational-naruto-quest.24481/"

quests = Dir.glob("docs/data/quests/*")


crawl = Crawl.new()
