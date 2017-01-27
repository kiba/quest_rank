require "json"
require "byebug"
quests = Dir.glob("docs/data/quests/*")

threads = Dir.glob("cache/threads/*")

threads.each do |t|
  byebug
end
