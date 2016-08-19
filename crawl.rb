require "mechanize"


agent = Mechanize.new()

start_url = "https://forums.sufficientvelocity.com/threads/marked-for-death-a-rational-naruto-quest.24481/"

page = agent.get(start_url)
