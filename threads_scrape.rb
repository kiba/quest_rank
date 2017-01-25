require "json"
require "nokogiri"
require "byebug"

files = Dir["cache/threads/*.html"]

# Integer sort.
files = files.sort_by {|f| f.split("cache/")[1].split(".html").first.to_i}

files.each do |f|
  content = Nokogiri::HTML(File.open(f))
end
