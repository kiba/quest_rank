load "crawl.rb"

url = "https://forums.sufficientvelocity.com/forums/quests.29/"
directory = "threads"

crawl = Crawl.new()
crawl.set_url(url)
crawl.set_dir(directory)
crawl.auto_download()
