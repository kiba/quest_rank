task :update do |t|
  sh "ruby quests_crawl.rb"
  sh "ruby scrape.rb"
  sh "ruby analyze.rb"
end
