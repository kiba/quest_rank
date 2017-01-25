require "mechanize"
class Crawl
  def initialize
    @agent = Mechanize.new()
    @agent.history_added = Proc.new {sleep 3}
    @files = Dir["cache/*.html"]
    @url = ""
    @target_dir = ""
  end
  def set_url url
    @url = url
  end
  def set_dir dir
    @target_dir = dir
  end
  def target_range
    print "beep"
    start = @files.size
    if start == 0
      start = 1
    end
    page = @agent.get(@url + "page-#{start}")
    last = page.css("div.PageNav").first["data-last"].to_i
    (start..last).to_a.each
  end
  def auto_download
    range = target_range()
    range.each do |n|
      download(n)
    end
  end
  def download n
    page = @agent.get(@url + "page-#{n}")
    puts "page #{n} saved."
    page.save!("cache/#{n}.html")
  end
end
