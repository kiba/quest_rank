require "json"
require "nokogiri"
require "byebug"

files = Dir["cache/threads/*.html"]

# Integer sort.
files = files.sort_by {|f|
  f.split("cache/threads/")[1].split(".html").first.to_i
}

results = []

files.each do |f|
  content = Nokogiri::HTML(File.open(f))
  threads = content.search("li.discussionListItem")
  threads.each do |t|
    if t["class"].match("sticky").nil? == true
      url = t.search("a")[1].attributes["href"].value.split("threads/").last
      id = t.values[0].split("thread-").last
      author = t.values.last
      create = t.search(".startDate").search(".DateTime").children.text
      update = t.search(".lastPost").search(".dateTime")[0].children[0].attributes["data-datestring"].value
      hash = {
        :id => id,
        :url => url,
        :author => author,
        :create => create,
        :update => update
      }
      results.push(hash)
    end
  end
end

data = JSON.pretty_generate(results)
File.open("docs/data/threads.json","w") do |f|
  f.write(data)
end
