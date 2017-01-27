require "json"
require "byebug"

directories = Dir.glob("docs/data/quests/*")
exclude = []
directories.each do |d|
  exclude.push(d.split("/").last)
end
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
