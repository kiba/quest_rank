require "json"
require "byebug"

directories = Dir.glob("docs/data/quests/*")
threads = JSON.parse(File.read("docs/data/threads.json"))
