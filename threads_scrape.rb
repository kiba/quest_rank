require "json"
require "nokogiri"
require "byebug"

files = Dir["cache/threads/*.html"]

# Integer sort.
files = files.sort_by {|f|
  f.split("cache/threads/")[1].split(".html").first.to_i
}

results = []

page = 0
files.each do |f|
  page += 1
  puts page
  content = Nokogiri::HTML(File.open(f))
  threads = content.search("li.discussionListItem")
  threads.each do |t|
    if t["class"].match("sticky").nil? == true
      id = t.values[0].split("thread-").last
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
      results.push(hash)
    end
  end
end

data = JSON.pretty_generate(results)
File.open("docs/data/threads.json","w") do |f|
  f.write(data)
end
