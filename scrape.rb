require "json"
require "nokogiri"

files = Dir["cache/*.html"]

posts = {}

content = Nokogiri::HTML(File.open(files[0]))

messages = content.search("li.message").each do |m|

  metadata = {
    :author => m.css("username").children.text,
    :date => m.search("div.messageMeta span.DateTime").children.text
  }
  posts.merge!(metadata)
end

puts posts
