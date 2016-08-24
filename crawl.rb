require "mechanize"
URL = "https://forums.sufficientvelocity.com/threads/marked-for-death-a-rational-naruto-quest.24481/"

class Crawl
  def initialize
    @agent = Mechanize.new()
    @agent.history_added = Proc.new {sleep 3}
    @files = Dir["cache/*.html"]
  end
  def target_range
    start = @files.size + 1
    page = @agent.get(URL + "page-#{start}")
    last = page.css("div.PageNav").first["data-last"].to_i - 1
    (start..last).to_a.each
  end
  def auto_download
    range = target_range()
    range.each do |n|
      page = @agent.get(URL + "page-#{n}")
      puts "page #{n} saved."
      page.save("cache/#{n}.html")
    end
  end
end

crawl = Crawl.new()
crawl.auto_download()
