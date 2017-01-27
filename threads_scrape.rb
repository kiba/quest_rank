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
      author = t.values.last
      create = t.search(".startDate").search(".DateTime").children.text
      update = t.search(".lastPost").search(".dateTime").search(".DateTime").text
      # update = t.search(".lastPost").search(".dateTime")[0].children[0].attributes["data-datestring"].value
      hash = {
        :id => id,
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
