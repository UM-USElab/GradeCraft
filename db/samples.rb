user_names = ['Ron Weasley','Fred Weasley','Harry Potter','Hermione Granger','Colin Creevey','Seamus Finnigan','Hannah Abbott','Pansy Parkinson','Zacharias Smith','Blaise Zabini', 'Draco Malfoy', 'Dean Thomas', 'Millicent Bulstrode', 'Terry Boot', 'Ernie Macmillan']

# Generate sample courses
Course.create! do |c|
  c.name = "Videogames & Learning"
  c.courseno = "ED222"
  c.year = Date.today.year 
  c.semester = semester 
  c.team_setting = true
  c.group_setting = true
  c.badge_setting = true
  c.has_assignment_submissions = true
  c.team_term = "Team"
  c.user_term = "Player"
  c.section_leader_term = "Team Leader"
end

Course.create! do |c|
  c.name = "Introduction to Political Science"
  c.courseno = "POLITSCI 101"
  c.year = Date.today.year 
  c.semester = semester 
  c.team_setting = true
  c.group_setting = true
  c.badge_setting = true
  c.has_assignment_submissions = true
  c.team_term = "Section"
  c.user_term = "Student"
  c.section_leader_term = "GSI"
  c.user_weight_amount_type = "Multiplier"
  c.multiplier_term = "Kapital"
  c.multiplier_default = 0.5
  c.user_weight_amount = 1 * rand(10)
  c.user_weight_amount_close_date = rand(4).weeks.from_now
end

Course.create! do |c|
  c.name = "PhD 2012 Cohort"
  c.courseno = "SIPHD2012"
  c.year = Date.today.year 
  c.semester = semester 
  c.team_setting = false
  c.group_setting = false
  c.badge_setting = true
  c.has_assignment_submissions = true
  c.team_term = "Section"
  c.user_term = "Student"
  c.section_leader_term = "GSI"
  c.user_weight_amount_type = "Multiplier"
  c.multiplier_term = "Kapital"
  c.multiplier_default = 0.5
  c.user_weight_amount = 1 * rand(10)
  c.user_weight_amount_close_date = rand(4).weeks.from_now
end
