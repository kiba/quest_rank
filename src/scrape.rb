require "json"
require "nokogiri"
require "byebug"

# Download a specific target.
argument = ARGV[0]

if !argument.nil?
  targets = [ARGV[0].to_i]
else
  targets = []
  lists = Dir["./docs/quests/*"]
  lists.each do |e|
    targets.push(e.split("/").last.split(".").first.to_i)
  end
end

def get_files target
  files = Dir["./cache/quests/#{target}/*.html"]
end

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

files = get_files(target)
# Integer sort.
files = files.sort_by {|f| f.split("./cache/quests/#{target}/")[1].split(".html").first.to_i}

posts = []
count = 0
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

File.open("./docs/data/quests/#{target}/data.json","w") do |f|
  f.write(posts)
end
