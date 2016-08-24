require "json"
require "nokogiri"
require "byebug"

files = Dir["cache/*.html"]

posts = []

files.each do |f|
  content = Nokogiri::HTML(File.open(f))
  li = content.search("li.message")
  if li.size != 25
    puts "Not standard number of replies at... " + f
  end
  messages = content.search("li.message").each do |m|
    hash = {
      :id => m["id"],
      :author => m["data-author"],
      :date => m.search("div.messageMeta span.DateTime").children.text
    }
    posts.push(hash.to_json)
  end
end

results = JSON.pretty_generate(posts)

File.open("doc/data.json","w") do |f|
  f.write(posts)
end
