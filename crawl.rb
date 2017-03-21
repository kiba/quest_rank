require "mechanize"
class Crawl
  def initialize
    @agent = Mechanize.new()
    @agent.robots = true
    @agent.history_added = Proc.new {sleep 6}
    @url = ""
    @target_dir = ""
  end
  def get_path
    if @target_dir.empty?
      path = "cache/"
    else
      path = "cache/" + @target_dir + "/"
    end
    return path
  end
  def set_url url
    @url = url
  end
  def set_dir dir
    @target_dir = dir
  end
  def target_range
    files = Dir[get_path() + "*.html"]
    start = files.size
    if start == 0
      start = 1
    end
    page = @agent.get(@url + "page-#{start}")
    css = page.css("div.PageNav")
    unless css.empty?
      last = css.first["data-last"].to_i
      return (start..last).to_a.each
    else
      return [1]
    end
  end
  def auto_download
    range = target_range()
    range.each do |n|
      times = 3
      download(n)
      times -= 1
    end
  end
  def download n
    times = 3
    begin
      page = @agent.get(@url + "page-#{n}")
    rescue
      times -= 1
      retry if times > 0
    end
    puts "page #{n} saved."
    page.save!(get_path() + "#{n}.html")

  end
end
