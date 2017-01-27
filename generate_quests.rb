require "json"
require "byebug"

pathway = "docs/data/quests/"
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
  dir = pathway + t["id"] + "/"
  unless File.exist?(dir)
    Dir.mkdir(dir)
    File.open(dir + "quest.json","w") do |f|
      f.write(JSON.pretty_generate(hash))
    end
    exit
  else
    "directory already exists."
  end
end
