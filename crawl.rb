require "mechanize"


agent = Mechanize.new()

page = agent.get('https://forums.sufficientvelocity.com/threads/marked-for-death-a-rational-naruto-quest.24481/')
