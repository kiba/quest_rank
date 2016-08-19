require "mechanize"

files = Dir["cache/*.html"]

agent = Mechanize.new()
agent.history_added = Proc.new {sleep 10}




def calculate_size agent
  start_url = "https://forums.sufficientvelocity.com/threads/marked-for-death-a-rational-naruto-quest.24481/"
  last = page.css("div.PageNav").first["data-last"].to_i
  page = agent.get(start_url)
  messages = page.css("ol.messageList li.message")
end
