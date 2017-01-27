require "json"
require "byebug"

directory = "docs/data/quests/"
exclude = []
threads = JSON.parse(File.read("docs/data/threads.json"))

threads.each do |t|
  hash = {
    :title => t["title"],
    :url => "https://forums.sufficientvelocity.com/threads/" + t["id"],
    :authors => [t["author"]],
    :description => "",
    :tags => t["tag"]
  }
end
