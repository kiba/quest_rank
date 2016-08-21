require "json"
require "nokogiri"
require "byebug"

files = Dir["cache/*.html"]

posts = []

content = Nokogiri::HTML(File.open(files[0]))

messages = content.search("li.message").each do |m|
  hash = {
    {
      :id => m["id"],
      :author => m["data-author"],
      :date => m.search("div.messageMeta span.DateTime").children.text
    }
  }
  posts.push(hash)
end

results = JSON.pretty_generate(posts)

File.open("test.json","w") do |f|
  f.write(posts)
end
