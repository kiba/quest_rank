task :update do |t|
  sh "ruby src/quests_crawl.rb"
  sh "ruby src/scrape.rb"
  sh "ruby src/analyze.rb"
end
