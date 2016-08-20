require "mechanize"

class Crawl
  def initialize
    @agent = Mechanize.new()
    @agent.history_added = Proc.new {sleep 10}
    @files = Dir["cache/*.html"]
  end
  def download
  end
end

crawl = Crawl.new()
#    messages = page.css("ol.messageList li.message")
