namespace :db do 
  desc "Task to clear out the database and replace it with sample data"
  task :sample => :environment do 