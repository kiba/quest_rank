require "optparse"
url = "https://forums.sufficientvelocity.com/threads/marked-for-death-a-rational-naruto-quest.24481/"

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: changes.rb [options]"
  opts.on("-pPAGE", "--page=PAGE", "Choose specificaly which page to download") do |p|
    options[:page] = p
  end

  opts.on("-h", "--help", "Print all commands.") do
    puts opts
    exit
  end
end.parse!

crawl = Crawl.new()
crawl.url = url
if options[:page] == nil
  crawl.auto_download()
else
  crawl.download(options[:page])
end
