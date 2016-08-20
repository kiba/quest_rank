require "json"
require "nokogiri"

files = Dir["cache/*.html"]

content = File.read(files[0])
