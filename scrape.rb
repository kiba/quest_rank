require "json"
require "nokogiri"

files = Dir["cache/*.html"]

content = Nokogiri::HTML(File.open(files[0]))
