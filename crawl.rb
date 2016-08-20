require "mechanize"

class Crawl
  def initialize
    @agent = Mechanize.new()
    @agent.history_added = Proc.new {sleep 10}
    @files = Dir["cache/*.html"]
  end
  def pages_to_download
    url = "https://forums.sufficientvelocity.com/threads/marked-for-death-a-rational-naruto-quest.24481/"
    start = @files.size
    if @files.size == 0
      start = 1
    end
    page = @agent.get(url + "page-#{start}")
    last = page.css("div.PageNav").first["data-last"].to_i - 1
    (start..last).to_a.each do |n|
      puts n
    end
  end
end

crawl = Crawl.new()
#    messages = page.css("ol.messageList li.message")
