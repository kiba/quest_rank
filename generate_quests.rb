require "json"
require "byebug"

directories = Dir.glob("docs/data/quests/*")
exclude = []
directories.each do |d|
  exclude.push(d.split("/").last)
end
threads = JSON.parse(File.read("docs/data/threads.json"))


t = threads[0]
hash = {
  :title => "",
  :url => "https://forums.sufficientvelocity.com/threads/" + threads[0],
  :description => "",
  :authors => [threads[0].author],

}
