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
      hash = {
        :id => id,
        :url => url
      }
      results.push(hash)
    end
  end
end
