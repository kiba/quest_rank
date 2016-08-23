require "json"

file = File.read("doc/data.json")

json = JSON.parse(file)
