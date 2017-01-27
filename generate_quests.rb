require "json"
require "byebug"

generated = Dir.glob("docs/data/quests/*")
threads = JSON.parse(File.read("docs/data/threads.json"))
