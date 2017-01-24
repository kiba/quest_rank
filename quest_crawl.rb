require "mechanize"
require "optparse"

URL = "https://forums.sufficientvelocity.com/forums/quests.29/"
class Crawl
  def initialize
    @agent = Mechanize.new()
    @agent.history_added = Proc.new {sleep 3}
  end
end
