task :update do |t|
  sh "ruby src/quests_crawl.rb 24481"
  sh "ruby src/scrape.rb"
  sh "ruby src/analyze.rb"
end
