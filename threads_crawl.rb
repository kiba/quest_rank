require "optparse"
load "crawl.rb"

url = "https://forums.sufficientvelocity.com/forums/quests.29/"

crawl = Crawl.new()
crawl.set_url(url)
crawl.auto_download()
