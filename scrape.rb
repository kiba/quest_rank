require "json"
require "nokogiri"
require "byebug"

files = Dir["cache/*.html"]

posts = []

files.each do |f|
  content = Nokogiri::HTML(File.open(f))
  replies = content.search("li.message")
  if replies.size != 25
    puts "Not standard number of replies at... " + f + " with " + replies.size.to_s
  end
  replies.each do |m|
    id = m["id"]
    author = m["data-author"]
    date = m.search("div.messageMeta span.DateTime").children.text
    if date == ""
      date = m.search("a.datePermalink abbr.DateTime").first["data-datestring"]
    end
    hash = {
      :id => id,
      :author => author,
      :date => date
    }
    posts.push(hash.to_json)
  end
end

results = JSON.pretty_generate(posts)

File.open("doc/data.json","w") do |f|
  f.write(posts)
end
