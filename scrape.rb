require "json"
require "nokogiri"
require "byebug"

files = Dir["cache/*.html"]

posts = {}

content = Nokogiri::HTML(File.open(files[0]))

messages = content.search("li.message").each do |m|

  metadata = {
    :author => m["data-author"],
    :id => m["id"],
    :date => m.search("div.messageMeta span.DateTime").children.text
  }
  posts.merge!(metadata)
end

puts posts
