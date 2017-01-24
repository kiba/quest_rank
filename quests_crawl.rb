require "mechanize"
require "optparse"

URL = "https://forums.sufficientvelocity.com/forums/quests.29/"
class Crawl
  def initialize
    @agent = Mechanize.new()
    @agent.history_added = Proc.new {sleep 3}
    @files = Dir["cache/threads/*.html"]
  end
  def target_range
    start = @files.size
    if start == 0
      start = 1
    end
  end
end
