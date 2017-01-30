load "crawl.rb"

file = File.open("progress.txt","r")

url = "https://forums.sufficientvelocity.com/forums/quests.29/"
directory = "threads"

crawl = Crawl.new()
crawl.set_url(url)
crawl.set_dir(directory)
crawl.auto_download()
