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
  byebug
  document = content.search("li.discussionListItem")
  id = t.values[0].split("thread-").las
  title =  t.search("a").search("a.PreviewTooltip").children.text
  author = t.values.last
  create = t.search(".startDate").search(".DateTime").children.text
  update = t.search(".lastPost").search(".dateTime").search(".DateTime").text
  tags = []
  t.search("a.tag").each do |tag|
    tags.push(tag.values[0].split("/")[1])
  end
  hash = {
    :id => id,
    :title => title,
    :author => author,
    :create => create,
    :update => update,
    :tags => tags
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
