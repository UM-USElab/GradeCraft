user_names = ['Ron Weasley','Fred Weasley','Harry Potter','Hermione Granger','Colin Creevey','Seamus Finnigan','Hannah Abbott','Pansy Parkinson','Zacharias Smith','Blaise Zabini', 'Draco Malfoy', 'Dean Thomas', 'Millicent Bulstrode', 'Terry Boot', 'Ernie Macmillan']

team_names = ['Harm & Hammer', 'Abusement Park','Silver Woogidy Woogidy Woogidy Snakes','Carpe Ludus','Eduception','Operation Unthinkable','Team Wang','The Carpal Tunnel Crusaders','Pwn Depot']

badge_names = ['Dream Interpreter', 'Inner Eye', 'Patronus Producer','Cheerful Charmer','Invisiblity Cloak','Marauders Map','Lumos','Rune Reader','Tea Leaf Guru','Wizard Chess Grand Master','Green Thumb','Gamekeeper','Seeker','Alchemist','Healer','Parseltongue','House Cup']

badge_icons = ['/badges/pos101/above_and_beyond.png','/badges/pos101/always_learning.png','/badges/pos101/awesome_aggregator.png','/badges/pos101/concentrator.png','/badges/pos101/courageous_failure.png','/badges/pos101/early_bird_special.png','/badges/pos101/examination_expert.png','/badges/pos101/gaining_experience.png','/badges/pos101/gamer.png','/badges/pos101/great_critic.png','/badges/pos101/learning_from_mistakes.png','/badges/pos101/level_one.png','/badges/pos101/participatory_democrat.png','/badges/pos101/personal.png','/badges/pos101/practice_makes_perfect.png','/badges/pos101/presentation_of_self.png','/badges/pos101/public_speaker.png']

grade_scheme_hash = { [0,600000] => 'F', [600000,649000] => 'D+', [650000,699999] => 'C-', [700000,749999] => 'C', [750000,799999] => 'C+', [800000,849999] => 'B-', [850000,899999] => 'B', [900000,949999] => 'B+', [950000,999999] => 'A-', [100000,1244999] => 'A', [1245000,1600000] => 'A+'}

#Generate badge set
BadgeSet.create! do |bs|
  bs.name = "Hogwarts Most Officially Official Badge Set"
end
puts "Awards may now be given!"

badges = []
badge_names.each do |badge_name|
  badges << Badge.create! do |b|
    b.badge_set_id = 1
    b.name = badge_name
    b.value = 100 * rand(10)
    b.icon = badge_icons.sample
    b.visible = "1"
  end
end
puts "Did someone need motivation? We found these badges in the Room of Requirements..."

# Generate sample courses
Course.create! do |c|
  c.name = "Videogames & Learning"
  c.courseno = "ED222"
  c.year = Date.today.year 
  c.semester = "Winter"
  c.user_term = "Player"
  c.section_leader_term = "Team Leader"
  c.group_term = "Group"
  c.max_group_size = 3
  c.min_group_size = 5
  c.team_term = "Team"
  c.team_setting = true
  c.teams_visible = true
  c.group_setting = true
  c.badge_setting = true
  c.badge_set_id = 1
  c.badge_use_scope = "Both"
  c.shared_badges = true
  c.badges_value = false
  c.has_assignment_submissions = true
  c.predictor_setting = true
  c.graph_display = false
end
default_course = Course.first
puts "Videogames and Learning has been installed"

teams = []
team_names.each do |team_name|
  teams << default_course.teams.create! do |t|
    t.name = team_name
  end
end
puts "The Team Competition has begun!"

# Generate sample students
students = []
user_names.each do |name|
  first_name, last_name = name.split(' ')
  username = name.parameterize.sub('-','.')
  students << User.create! do |u|
    u.username = username
    u.first_name = first_name
    u.last_name = last_name
    u.email = "#{username}@hogwarts.edu"
    u.password = 'uptonogood'
    u.default_course_id = default_course.id
    u.courses = [default_course]
  end
end
puts "Generated #{students.count} unruly students"

students.each do |student|
  TeamMembership.create! do |tm|
    tm.user = student
    tm.team = teams.sample
  end
end
puts "Added students to teams"


# Generate sample admin
User.create! do |u|
  u.username = 'albus'
  u.first_name = 'Albus'
  u.last_name = 'Dumbledore'
  u.role = 'admin'
  u.email = 'dumbledore@hogwarts.edu'
  u.password = 'fawkes'
  u.default_course_id = default_course.id
  u.courses = [default_course]
end
puts "Albus Dumbledore just apparated into Hogwarts"

# Generate sample professor
User.create! do |u|
  u.username = 'severus'
  u.first_name = 'Severus'
  u.last_name = 'Snape'
  u.role = 'professor'
  u.email = 'snape@hogwarts.edu'
  u.password = 'lily'
  u.default_course_id = default_course.id
  u.courses = [default_course]
end
puts "Severus Snape has been spotted in Slytherin House"

# Generate sample GSI
students << User.create! do |u|
  u.username = 'percy.weasley'
  u.first_name = 'Percy'
  u.last_name = 'Weasley'
  u.role = 'gsi'
  u.email = 'percy.weasley@hogwarts.edu'
  u.password = 'bestprefect'
  u.default_course_id = default_course.id
  u.courses = [default_course]
end
puts "Percy Weasley has arrived on campus, on time as usual"

AssignmentType.create! do |at|
  at.course_id = default_course.id
  at.name = "Attendance"
  at.point_setting = "Individually"
  at.points_predictor_display = "Fixed"
  at.resubmission = false
  at.max_value = "120000"
  at.predictor_description = "We will work to build a learning community in EDUC 222, and I want this to be a great learning experience for all. To do this requires that you commit to the class and participate."
  at.universal_point_value = "5000"
  at.due_date_present = true
  at.order_placement = 1
  at.mass_grade = true
  at.mass_grade_type = "Checkbox"
end
puts "Come to class."

AssignmentType.create! do |at|
  at.course_id = default_course.id
  at.name = "Reading Reactions"
  at.point_setting = "Individually"
  at.points_predictor_display = "Select"
  at.resubmission = false
  at.predictor_description = "Each week, you must write a concise summary or analysis of the reading for that week of no more than 200 words! (200 words is roughly equivalent to one-half page, double-spaced.) Your 201st word will suffer a terrible fate... "
  at.due_date_present = true
  at.order_placement = 2
  at.mass_grade = true
  at.mass_grade_type = "Select"
end
puts "Do your readings."


AssignmentType.create! do |at|
  at.course_id = default_course.id
  at.name = "Blogging"
  at.point_setting = "Individually"
  at.points_predictor_display = "Slider"
  at.resubmission = false
  at.max_value = "60000"
  at.predictor_description = "The course blog allows you to reflect on your learning, or to report on and/or critique ideas and reports about games and learning that you encounter in your daily travels online and offline."
  at.order_placement = 3
  at.mass_grade = true
  at.mass_grade_type = "Radio"
end
puts "Blogging is great for filling in missed points in other areas"

AssignmentType.create! do |at|
  at.course_id = default_course.id
  at.name = "Learning from Playing a Game"
  at.point_setting = "Individually"
  at.points_predictor_display = "Slider"
  at.resubmission = false
  at.due_date_present = true
  at.order_placement = 4
  at.mass_grade = false
end
puts "This is the good stuff :)"

AssignmentType.create! do |at|
  at.course_id = default_course.id
  at.name = "Boss Battles"
  at.point_setting = "Individually"
  at.points_predictor_display = "Slider"
  at.resubmission = false
  at.due_date_present = true
  at.order_placement = 5
  at.mass_grade = false
end
puts "Challenges!"

Assignment.create! do |a|
  a.course_id = default_course.id
  a.assignment_type_id = 1
  a.name = "Class 1"
  a.point_total = 5000
  a.due_date = rand(5).weeks.ago
  a.has_assignment_submissions = false
  a.release_necessary = false
  a.open_date = "09/01/2013"
  a.grade_scope = "Individual"
end
puts "Attendance 1 has been posted!"

students.each do |student|
  Grade.create! do |g|
    g.assignment_id = 1
    g.gradeable = student
    g.raw_score = 5000 * [0,1].sample
  end
end
puts "Grades from Attendance 1 have been posted!"

Assignment.create! do |a|
  a.course_id = default_course.id
  a.assignment_type_id = 1
  a.name = "Class 2"
  a.point_total = 5000
  a.due_date = rand(4).weeks.ago
  a.has_assignment_submissions = false
  a.release_necessary = false
  a.open_date = "014/01/2013"
  a.grade_scope = "Individual"
end
puts "Attendance 2 has been posted!"

students.each do |student|
  Grade.create! do |g|
    g.assignment_id = 11
    g.gradeable = student
    g.raw_score = 5000 * [0,1].sample
  end
end
puts "Grades from Attendance 2 have been posted!"


Assignment.create! do |a|
  a.course_id = default_course.id
  a.assignment_type_id = 1
  a.name = "Class 3"
  a.point_total = 5000
  a.due_date = rand(3).weeks.ago
  a.has_assignment_submissions = false
  a.release_necessary = false
  a.open_date = "16/01/2013"
  a.grade_scope = "Individual"
end
puts "Attendance 3 has been posted!"

students.each do |student|
  Grade.create! do |g|
    g.assignment_id = 21
    g.gradeable = student
    g.raw_score = 5000 * [0,1].sample
  end
end
puts "Grades from Attendance 3 have been posted!"

Assignment.create! do |a|
  a.course_id = default_course.id
  a.assignment_type_id = 1
  a.name = "Class 4"
  a.point_total = 5000
  a.due_date = rand(2).weeks.ago
  a.has_assignment_submissions = false
  a.release_necessary = false
  a.open_date = "21/01/2013"
  a.grade_scope = "Individual"
end
puts "Attendance 4 has been posted!"

students.each do |student|
  Grade.create! do |g|
    g.assignment_id = 31
    g.gradeable = student
    g.raw_score = 5000 * [0,1].sample
  end
end
puts "Grades from Attendance 4 have been posted!"

Assignment.create! do |a|
  a.course_id = default_course.id
  a.assignment_type_id = 1
  a.name = "Class 5"
  a.point_total = 5000
  a.due_date = rand(1).weeks.ago
  a.has_assignment_submissions = false
  a.release_necessary = false
  a.open_date = "23/01/2013"
  a.grade_scope = "Individual"
end
puts "Attendance 5 has been posted!"

students.each do |student|
  Grade.create! do |g|
    g.assignment_id = 41
    g.gradeable = student
    g.raw_score = 5000 * [0,1].sample
  end
end
puts "Grades from Attendance 5 have been posted!"

Assignment.create! do |a|
  a.course_id = default_course.id
  a.assignment_type_id = 1
  a.name = "Class 6"
  a.point_total = 5000
  a.due_date = rand(1).weeks.from_now
  a.has_assignment_submissions = false
  a.release_necessary = false
  a.open_date = "28/01/2013"
  a.grade_scope = "Individual"
end
puts "Attendance 6 has been posted!"

Assignment.create! do |a|
  a.course_id = default_course.id
  a.assignment_type_id = 1
  a.name = "Class 7"
  a.point_total = 5000
  a.due_date = rand(2).weeks.from_now
  a.has_assignment_submissions = false
  a.release_necessary = false
  a.open_date = "30/01/2013"
  a.grade_scope = "Individual"
end
puts "Attendance 7 has been posted!"

Assignment.create! do |a|
  a.course_id = default_course.id
  a.assignment_type_id = 1
  a.name = "Class 8"
  a.point_total = 5000
  a.due_date = rand(3).weeks.from_now
  a.has_assignment_submissions = false
  a.release_necessary = false
  a.open_date = "04/02/2013"
  a.grade_scope = "Individual"
end
puts "Attendance 8 has been posted!"

Assignment.create! do |a|
  a.course_id = default_course.id
  a.assignment_type_id = 1
  a.name = "Class 9"
  a.point_total = 5000
  a.due_date = rand(4).weeks.from_now
  a.has_assignment_submissions = false
  a.release_necessary = false
  a.open_date = "06/02/2013"
  a.grade_scope = "Individual"
end
puts "Attendance 9 has been posted!"

Assignment.create! do |a|
  a.course_id = default_course.id
  a.assignment_type_id = 1
  a.name = "Class 10"
  a.point_total = 5000
  a.due_date = rand(5).weeks.from_now
  a.has_assignment_submissions = false
  a.release_necessary = false
  a.open_date = "11/02/2013"
  a.grade_scope = "Individual"
end
puts "Attendance 10 has been posted!"

Assignment.create! do |a|
  a.course_id = default_course.id
  a.assignment_type_id = 11
  a.name = "Week 1"
  a.point_total = 5000
  a.due_date = rand(5).weeks.ago
  a.has_assignment_submissions = false
  a.release_necessary = false
  a.open_date = "14/02/2013"
  a.grade_scope = "Individual"
end
puts "Reading Reaction 1 has been posted!"

students.each do |student|
  Grade.create! do |g|
    g.assignment_id = 101
    g.gradeable = student
    g.raw_score = 5000 * [0,1].sample
  end
end
puts "Grades from Reading Reaction 1 have been posted!"

Assignment.create! do |a|
  a.course_id = default_course.id
  a.assignment_type_id = 11
  a.name = "Week 2"
  a.point_total = 5000
  a.due_date = rand(4).weeks.ago
  a.has_assignment_submissions = false
  a.release_necessary = false
  a.open_date = "14/02/2013"
  a.grade_scope = "Individual"
end
puts "Reading Reaction 2 has been posted!"

students.each do |student|
  Grade.create! do |g|
    g.assignment_id = 111
    g.gradeable = student
    g.raw_score = 5000 * [0,1].sample
  end
end
puts "Grades from Reading Reaction 2 have been posted!"

Assignment.create! do |a|
  a.course_id = default_course.id
  a.assignment_type_id = 11
  a.name = "Week 3"
  a.point_total = 5000
  a.due_date = rand(3).weeks.ago
  a.has_assignment_submissions = false
  a.release_necessary = false
  a.open_date = "14/02/2013"
  a.grade_scope = "Individual"
end
puts "Reading Reaction 3 has been posted!"

students.each do |student|
  Grade.create! do |g|
    g.assignment_id = 121
    g.gradeable = student
    g.raw_score = 5000 * [0,1].sample
  end
end
puts "Grades from Reading Reaction 3 have been posted!"

Assignment.create! do |a|
  a.course_id = default_course.id
  a.assignment_type_id = 11
  a.name = "Week 4"
  a.point_total = 5000
  a.due_date = rand(2).weeks.ago
  a.has_assignment_submissions = false
  a.release_necessary = false
  a.open_date = "14/02/2013"
  a.grade_scope = "Individual"
end
puts "Reading Reaction 4 has been posted!"

students.each do |student|
  Grade.create! do |g|
    g.assignment_id = 131
    g.gradeable = student
    g.raw_score = 5000 * [0,1].sample
  end
end
puts "Grades from Reading Reaction 4 have been posted!"

Assignment.create! do |a|
  a.course_id = default_course.id
  a.assignment_type_id = 11
  a.name = "Week 5"
  a.point_total = 5000
  a.due_date = rand(1).weeks.ago
  a.has_assignment_submissions = false
  a.release_necessary = false
  a.open_date = "14/02/2013"
  a.grade_scope = "Individual"
end
puts "Reading Reaction 5 has been posted!"

students.each do |student|
  Grade.create! do |g|
    g.assignment_id = 141
    g.gradeable = student
    g.raw_score = 5000 * [0,1].sample
  end
end
puts "Grades from Reading Reaction 5 have been posted!"

Assignment.create! do |a|
  a.course_id = default_course.id
  a.assignment_type_id = 11
  a.name = "Week 6"
  a.point_total = 5000
  a.due_date = rand(1).weeks.from_now
  a.has_assignment_submissions = false
  a.release_necessary = false
  a.open_date = "14/02/2013"
  a.grade_scope = "Individual"
end
puts "Reading Reaction 6 has been posted!"

Assignment.create! do |a|
  a.course_id = default_course.id
  a.assignment_type_id = 11
  a.name = "Week 7"
  a.point_total = 5000
  a.due_date = rand(2).weeks.from_now
  a.has_assignment_submissions = false
  a.release_necessary = false
  a.open_date = "14/02/2013"
  a.grade_scope = "Individual"
end
puts "Reading Reaction 7 has been posted!"

Assignment.create! do |a|
  a.course_id = default_course.id
  a.assignment_type_id = 11
  a.name = "Week 8"
  a.point_total = 5000
  a.due_date = rand(3).weeks.from_now
  a.has_assignment_submissions = false
  a.release_necessary = false
  a.open_date = "14/02/2013"
  a.grade_scope = "Individual"
end
puts "Reading Reaction 8 has been posted!"

Assignment.create! do |a|
  a.course_id = default_course.id
  a.assignment_type_id = 11
  a.name = "Week 9"
  a.point_total = 5000
  a.due_date = rand(4).weeks.from_now
  a.has_assignment_submissions = false
  a.release_necessary = false
  a.open_date = "14/02/2013"
  a.grade_scope = "Individual"
end
puts "Reading Reaction 9 has been posted!"

Assignment.create! do |a|
  a.course_id = default_course.id
  a.assignment_type_id = 11
  a.name = "Week 10"
  a.point_total = 5000
  a.due_date = rand(5).weeks.from_now
  a.has_assignment_submissions = false
  a.release_necessary = false
  a.open_date = "14/02/2013"
  a.grade_scope = "Individual"
end
puts "Reading Reaction 10 has been posted!"

Assignment.create! do |a|
  a.course_id = default_course.id
  a.assignment_type_id = 21
  a.name = "Blog Post 1"
  a.point_total = 5000
  a.has_assignment_submissions = true
  a.release_necessary = false
  a.grade_scope = "Individual"
end
puts "Blog Post 1 has been posted!"

students.each do |student|
  Grade.create! do |g|
    g.assignment_id = 201
    g.gradeable = student
    g.raw_score = 5000 * [0,1].sample
  end
end
puts "Grades from Blog Post 1 have been posted!"

Assignment.create! do |a|
  a.course_id = default_course.id
  a.assignment_type_id = 21
  a.name = "Blog Post 2"
  a.point_total = 5000
  a.has_assignment_submissions = true
  a.release_necessary = false
  a.grade_scope = "Individual"
end
puts "Blog Post 2 has been posted!"

students.each do |student|
  Grade.create! do |g|
    g.assignment_id = 211
    g.gradeable = student
    g.raw_score = 5000 * [0,1].sample
  end
end
puts "Grades from Blog Post 2 have been posted!"

Assignment.create! do |a|
  a.course_id = default_course.id
  a.assignment_type_id = 21
  a.name = "Blog Post 3"
  a.point_total = 5000
  a.has_assignment_submissions = true
  a.release_necessary = false
  a.grade_scope = "Individual"
end
puts "Blog Post 3 has been posted!"

Assignment.create! do |a|
  a.course_id = default_course.id
  a.assignment_type_id = 21
  a.name = "Blog Post 4"
  a.point_total = 5000
  a.has_assignment_submissions = true
  a.release_necessary = false
  a.grade_scope = "Individual"
end
puts "Blog Post 4 has been posted!"

Assignment.create! do |a|
  a.course_id = default_course.id
  a.assignment_type_id = 21
  a.name = "Blog Post 5"
  a.point_total = 5000
  a.has_assignment_submissions = true
  a.release_necessary = false
  a.grade_scope = "Individual"
end
puts "Blog Post 5 has been posted!"

Assignment.create! do |a|
  a.course_id = default_course.id
  a.assignment_type_id = 21
  a.name = "Blog Post 6"
  a.point_total = 5000
  a.has_assignment_submissions = true
  a.release_necessary = false
  a.grade_scope = "Individual"
end
puts "Blog Post 6 has been posted!"

Assignment.create! do |a|
  a.course_id = default_course.id
  a.assignment_type_id = 21
  a.name = "Blog Comment 1"
  a.point_total = 5000
  a.has_assignment_submissions = true
  a.release_necessary = false
  a.grade_scope = "Individual"
end
puts "Blog Comment 1 has been posted!"

Assignment.create! do |a|
  a.course_id = default_course.id
  a.assignment_type_id = 21
  a.name = "Blog Comment 2"
  a.point_total = 5000
  a.has_assignment_submissions = true
  a.release_necessary = false
  a.grade_scope = "Individual"
end
puts "Blog Comment 2 has been posted!"

Assignment.create! do |a|
  a.course_id = default_course.id
  a.assignment_type_id = 21
  a.name = "Blog Comment 3"
  a.point_total = 5000
  a.has_assignment_submissions = true
  a.release_necessary = false
  a.grade_scope = "Individual"
end
puts "Blog Comment 3 has been posted!"

Assignment.create! do |a|
  a.course_id = default_course.id
  a.assignment_type_id = 21
  a.name = "Blog Comment 4"
  a.point_total = 5000
  a.has_assignment_submissions = true
  a.release_necessary = false
  a.grade_scope = "Individual"
end
puts "Blog Comment 4 has been posted!"

Assignment.create! do |a|
  a.course_id = default_course.id
  a.assignment_type_id = 21
  a.name = "Blog Comment 5"
  a.point_total = 5000
  a.has_assignment_submissions = true
  a.release_necessary = false
  a.grade_scope = "Individual"
end
puts "Blog Comment 5 has been posted!"


Assignment.create! do |a|
  a.course_id = default_course.id
  a.assignment_type_id = 31
  a.name = "Game Selection Paper"
  a.point_total = 80000
  a.due_date = rand(3).weeks.ago
  a.has_assignment_submissions = true
  a.release_necessary = true
  a.open_date = "14/02/2013"
  a.grade_scope = "Individual"
end
puts "Game Selection Paper has been posted!"

students.each do |student|
  Grade.create! do |g|
    g.assignment_id = 301
    g.gradeable = student
    g.raw_score = 80000 * [0,1].sample
  end
end
puts "Grades from Game Selection Paper have been posted!"

Assignment.create! do |a|
  a.course_id = default_course.id
  a.assignment_type_id = 31
  a.name = "Game Play Update Paper 1"
  a.point_total = 120000
  a.due_date = rand(3).weeks.from_now
  a.has_assignment_submissions = true
  a.release_necessary = true
  a.open_date = "14/02/2013"
  a.grade_scope = "Individual"
end
puts "Game Play Update Paper 1 has been posted!"

Assignment.create! do |a|
  a.course_id = default_course.id
  a.assignment_type_id = 31
  a.name = "Game Play Update Paper 2"
  a.point_total = 120000
  a.due_date = rand(5).weeks.from_now
  a.has_assignment_submissions = true
  a.release_necessary = true
  a.open_date = "14/02/2013"
  a.grade_scope = "Individual"
end
puts "Game Play Update Paper 2 has been posted!"

Assignment.create! do |a|
  a.course_id = default_course.id
  a.assignment_type_id = 31
  a.name = "Game Play Reflection Paper"
  a.point_total = 160000
  a.due_date = rand(7).weeks.from_now
  a.has_assignment_submissions = true
  a.release_necessary = true
  a.open_date = "14/02/2013"
  a.grade_scope = "Individual"
end
puts "Game Play Reflection Paper has been posted!"

Assignment.create! do |a|
  a.course_id = default_course.id
  a.assignment_type_id = 41
  a.name = "Individual Paper/Project 1"
  a.point_total = 200000
  a.due_date = rand(4).weeks.from_now
  a.has_assignment_submissions = true
  a.release_necessary = true
  a.open_date = "14/02/2013"
  a.grade_scope = "Individual"
end
puts "Individual Project 1 has been posted!"

Assignment.create! do |a|
  a.course_id = default_course.id
  a.assignment_type_id = 41
  a.name = "Individual Paper/Project 2"
  a.point_total = 300000
  a.due_date = rand(7).weeks.from_now
  a.has_assignment_submissions = true
  a.release_necessary = true
  a.open_date = "14/02/2013"
  a.grade_scope = "Individual"
end
puts "Individual Project 2 has been posted!"

Assignment.create! do |a|
  a.course_id = default_course.id
  a.assignment_type_id = 41
  a.name = "Group Game Design Project"
  a.point_total = 400000
  a.due_date = rand(7).weeks.from_now
  a.has_assignment_submissions = true
  a.release_necessary = true
  a.open_date = "14/02/2013"
  a.grade_scope = "Group"
end
puts "Group Game Design has been posted!"

course_grade_scheme = CourseGradeScheme.new(:name => 'N.E.W.T. Grades')
grade_scheme_hash.each do |range,name|
  course_grade_scheme.course_grade_scheme_elements.new do |e|
    e.name = name
    e.low_range = range.first
    e.high_range = range.last
  end
end
course_grade_scheme.courses = Course.all
course_grade_scheme.save!
puts "Installed N.E.W.T. grade scheme for each course"