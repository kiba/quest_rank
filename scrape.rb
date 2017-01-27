require "json"
require "nokogiri"
require "byebug"

files = Dir["cache/*.html"]

posts = []

def find_date m
  date = m.search("div.messageMeta span.DateTime").children.text
  if date == ""
    date = m.search("a.datePermalink abbr.DateTime").first["data-datestring"]
  end
  if date == ""
    byebug
  end
  return date
end

count = 0

# Integer sort.
files = files.sort_by {|f| f.split("cache/")[1].split(".html").first.to_i}

files.each do |f|
  content = Nokogiri::HTML(File.open(f))
  replies = content.search("li.message")
  count += replies.size
  if replies.size != 25
    puts "Not standard number of replies at... " + f + " with " + replies.size.to_s
  end
  replies.each do |m|
    id = m["id"]
    author = m["data-author"]
    date = find_date(m)
    hash = {
      :id => id,
      :author => author,
      :date => date
    }
    posts.push(hash.to_json)
  end
end

puts "There are " + count.to_s + " posts."
results = JSON.pretty_generate(posts)

File.open("docs/data/quests/24481/data.json","w") do |f|
  f.write(posts)
end
