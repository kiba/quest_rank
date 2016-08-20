require "mechanize"

class Crawl
  def initialize
    @agent = Mechanize.new()
    @agent.history_added = Proc.new {sleep 10}
    @files = Dir["cache/*.html"]
  end
  def target_range
    url = "https://forums.sufficientvelocity.com/threads/marked-for-death-a-rational-naruto-quest.24481/"
    start = @files.size + 1
    page = @agent.get(url + "page-#{start}")
    messages = page.css("ol.messageList li.message")
    return [] unless messages.size == 25
    last = page.css("div.PageNav").first["data-last"].to_i - 1
    (start..3).to_a.each
  end
  def download
    range = target_range()
    range.each do |r|
      page = @agent(url + "page-#{start}")
      puts "page #{start} saved."
      page.file.save("cache/#{start}.html")
    end
  end
end

crawl = Crawl.new()
