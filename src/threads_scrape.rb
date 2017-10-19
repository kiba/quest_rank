require "json"
require "nokogiri"
require "byebug"

def get_quests
  quests = []
  Dir["cache/quests/*"].each do |path|
    quests.push(path.split("/").last)
  end
  quests
end


def get_metadata quest
  results = []
  filename = "cache/quests/" + quest + "/1.html"
  content = Nokogiri::HTML(File.open(filename))
  title =  content.search("title").children.text.split("|").first.strip
  message = content.search("li.message")[0]
  author = message["data-author"]
  create = message.search(".DateTime").children.last.text
  hash = {
    :id => quest,
    :title => title,
    :author => author,
    :create => create,
  }
  return hash
end

quests = get_quests()
results = []
quests.each do |q|
  results.push(get_metadata(q))
end

data = JSON.pretty_generate(results)
File.open("docs/data/threads.json","w") do |f|
  f.write(data)
end
