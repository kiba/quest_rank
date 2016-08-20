require "json"
require "nokogiri"

files = Dir["cache/*.html"]

post = {}

content = Nokogiri::HTML(File.open(files[0]))

messages = content.search("li.message")

dates = messages.search("span.DateTime")

dates.each do |d|
  puts d["title"]
end
