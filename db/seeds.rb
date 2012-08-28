# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Generate Videogames & Learning

courses = []

courses << Course.create! do |c|
  c.name = "Videogames & Learning"
  c.courseno = 'EDUC 222'
  c.year = Date.today.year
  c.semester = "Fall"
  c.badge_setting = "true"
  c.team_setting = "true"
  c.user_term = "Player"
  c.team_term = "Team"
  c.group_setting = "true"
  c.team_roles = "true"
  c.section_leader_term = "Team Leader"
  c.group_term = "Group"
end

puts 'Videogames & Learning will be running this Winter!'

courses << Course.create! do |c|
  c.name = 'Introduction to Political Science'
  c.courseno = 'POLSCI 101'
  c.year = Date.today.year
  c.semester = "Fall"
  c.badge_setting = "true"
  c.team_setting = "true"
  c.user_term = "Student"
  c.team_term = "Section"
  c.group_setting = "true"
  c.team_roles = "true"
  c.section_leader_term = "GSI"
  c.group_term = "Group"
end

puts 'Political Science FTW!'

courses << Course.create! do |c|
  c.name = 'Gamification for Business'
  c.courseno = 'LGST/OPIM 240'
  c.year = "2013"
  c.semester = "Fall"
  c.badge_setting = "true"
  c.team_setting = "true"
  c.user_term = "Player"
  c.team_term = "Guild"
  c.group_setting = "true"
  c.team_roles = "true"
  c.group_term = "PuG"
end

puts "Wharton in the house!"

# Generate admin
User.create! do |u|
  u.username = 'cholma'
  u.first_name = 'Caitlin'
  u.last_name = 'Holman'
  u.role = 'admin'
  u.email = 'cholma@umich.edu'
  u.courses = courses
  u.password = 'fawkes'
end
puts "And we have an admin"

# Generate Barry
User.create! do |u|
  u.username = 'severus'
  u.first_name = 'Barry'
  u.last_name = 'Fishman'
  u.role = 'admin'
  u.email = 'bfishman@umich.edu'
  u.courses = courses
end
puts "Barry is here..."

# Generate Cory
User.create! do |u|
  u.username = 'kaufmanc'
  u.first_name = 'Cory'
  u.last_name = 'Kaufman-Schofield'
  u.role = 'admin'
  u.email = 'cory@corykaufman.com'
  u.courses = courses
end
puts "Thank goodness for Cory"
