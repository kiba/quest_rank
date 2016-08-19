require "mechanize"

files = Dir["cache/*.html"]

agent = Mechanize.new()
agent.history_added = Proc.new {sleep 10}

start_url = "https://forums.sufficientvelocity.com/threads/marked-for-death-a-rational-naruto-quest.24481/"

page = agent.get(start_url)

last = page.css("div.PageNav").first["data-last"].to_i

#messages = page.css("ol")
