user_names = ['Ron Weasley','Fred Weasley','Harry Potter','Hermione Granger','Colin Creevey','Seamus Finnigan','Hannah Abbott','Pansy Parkinson','Zacharias Smith','Blaise Zabini', 'Draco Malfoy', 'Dean Thomas', 'Millicent Bulstrode', 'Terry Boot', 'Ernie Macmillan']

team_names = ['Harm & Hammer', 'Abusement Park','Silver Woogidy Woogidy Woogidy Snakes','Carpe Ludus','Eduception','Operation Unthinkable','Team Wang','The Carpal Tunnel Crusaders','Pwn Depot']

badge_names = ['Dream Interpreter', 'Inner Eye', 'Patronus Producer','Cheerful Charmer','Invisiblity Cloak','Marauders Map','Lumos','Rune Reader','Tea Leaf Guru','Wizard Chess Grand Master','Green Thumb','Gamekeeper','Seeker','Alchemist','Healer','Parseltongue','House Cup']

badge_icons = ['/badges/pos101/above_and_beyond.png','/badges/pos101/always_learning.png','/badges/pos101/awesome_aggregator.png','/badges/pos101/concentrator.png','/badges/pos101/courageous_failure.png','/badges/pos101/early_bird_special.png','/badges/pos101/examination_expert.png','/badges/pos101/gaining_experience.png','/badges/pos101/gamer.png','/badges/pos101/great_critic.png','/badges/pos101/learning_from_mistakes.png','/badges/pos101/level_one.png','/badges/pos101/participatory_democrat.png','/badges/pos101/personal.png','/badges/pos101/practice_makes_perfect.png','/badges/pos101/presentation_of_self.png','/badges/pos101/public_speaker.png']

grade_scheme_hash = { [0,600000] => 'F', [600000,649000] => 'D+', [650000,699999] => 'C-', [700000,749999] => 'C', [750000,799999] => 'C+', [800000,849999] => 'B-', [850000,899999] => 'B', [900000,949999] => 'B+', [950000,999999] => 'A-', [100000,1244999] => 'A', [1245000,1600000] => 'A+'}

#Generate badge set
badge_set = BadgeSet.create! do |bs|
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
  c.badge_sets << badge_set
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
    u.default_course = default_course
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
  u.default_course = default_course
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
  u.default_course = default_course
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
  u.default_course = default_course
  u.courses = [default_course]
end
puts "Percy Weasley has arrived on campus, on time as usual"

assignment_types = {}
assignment_types[:attendance] = AssignmentType.create! do |at|
  at.course = default_course
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

assignment_types[:reading_reaction] = AssignmentType.create! do |at|
  at.course = default_course
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

assignment_types[:blogging] = AssignmentType.create! do |at|
  at.course = default_course
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

assignment_types[:lfpg] = AssignmentType.create! do |at|
  at.course = default_course
  at.name = "Learning from Playing a Game"
  at.point_setting = "Individually"
  at.points_predictor_display = "Slider"
  at.resubmission = false
  at.due_date_present = true
  at.order_placement = 4
  at.mass_grade = false
end
puts "This is the good stuff :)"

assignment_types[:boss_battles] = AssignmentType.create! do |at|
  at.course = default_course
  at.name = "Boss Battles"
  at.point_setting = "Individually"
  at.points_predictor_display = "Slider"
  at.resubmission = false
  at.due_date_present = true
  at.order_placement = 5
  at.mass_grade = false
end
puts "Challenges!"

grinding_assignments = []

1.upto(10).each do |n|
  grinding_assignments << Assignment.create! do |a|
    a.course = default_course
    a.assignment_type = assignment_types[:attendance]
    a.name = "Class #{n}"
    a.point_total = 5000
    a.due_date = rand(n - 6).weeks.ago
    a.has_assignment_submissions = false
    a.release_necessary = false
    a.grade_scope = "Individual"
  end
  
  grinding_assignments << Assignment.create! do |a|
    a.course = default_course
    a.assignment_type = assignment_types[:reading_reactions]
    a.name = "Reading Reaction #{n}"
    a.point_total = 5000
    a.due_date = rand(n - 6).weeks.ago
    a.has_assignment_submissions = false
    a.release_necessary = true
    a.grade_scope = "Individual"
  end
end
puts "Attendance and Reading Reaction classes have been posted!"

grinding_assignments.each do |assignment|
  next unless assignment.due_date.past? 

  students.each do |student|
    assignment.grades.create! do |grade|
      grade.gradeable = student
      grade.raw_score = assignment.point_total * [0, 1].sample 
    end
  end
end
puts "Attendance and Reading Reaction scores have been posted!"

blog_assignments = []

1.upto(5).each do |n|
  blog_assignments << Assignment.create! do |a|
    a.course = default_course
    a.assignment_type = assignment_types[:blogging]
    a.name = "Blog Post #{n}"
    a.point_total = 5000
    a.has_assignment_submissions = true
    a.release_necessary = false
    a.grade_scope = "Individual"
  end
  
  blog_assignments << Assignment.create! do |a|
    a.course = default_course
    a.assignment_type = assignment_types[:blogging]
    a.name = "Blog Comment #{n}"
    a.point_total = 2000
    a.has_assignment_submissions = true
    a.release_necessary = false
    a.grade_scope = "Individual"
  end
end

blog_assignments.each_with_index do |assignment, i|
  next if i % 2 == 0 
  students.each do |student|
    assignment.grades.create! do |grade|
      grade.gradeable = student
      grade.raw_score = assignment.point_total * [0, 1].sample 
    end
  end
end
puts "Blogging assignments and scores have been posted!"

assignments = []

assignments << Assignment.create! do |a|
  a.course = default_course
  a.assignment_type = assignment_types[3]
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
    g.assignment = assignments.last
    g.gradeable = student
    g.raw_score = 80000 * [0,1].sample
  end
end
puts "Grades from Game Selection Paper have been posted!"

assignments << Assignment.create! do |a|
  a.course = default_course
  a.assignment_type = assignment_types[3]
  a.name = "Game Play Update Paper 1"
  a.point_total = 120000
  a.due_date = rand(3).weeks.from_now
  a.has_assignment_submissions = true
  a.release_necessary = true
  a.open_date = "14/02/2013"
  a.grade_scope = "Individual"
end
puts "Game Play Update Paper 1 has been posted!"

assignments << Assignment.create! do |a|
  a.course = default_course
  a.assignment_type = assignment_types[3]
  a.name = "Game Play Update Paper 2"
  a.point_total = 120000
  a.due_date = rand(5).weeks.from_now
  a.has_assignment_submissions = true
  a.release_necessary = true
  a.open_date = "14/02/2013"
  a.grade_scope = "Individual"
end
puts "Game Play Update Paper 2 has been posted!"

assignments << Assignment.create! do |a|
  a.course = default_course
  a.assignment_type = assignment_types[3]
  a.name = "Game Play Reflection Paper"
  a.point_total = 160000
  a.due_date = rand(7).weeks.from_now
  a.has_assignment_submissions = true
  a.release_necessary = true
  a.open_date = "14/02/2013"
  a.grade_scope = "Individual"
end
puts "Game Play Reflection Paper has been posted!"

assignments << Assignment.create! do |a|
  a.course = default_course
  a.assignment_type = assignment_types[4]
  a.name = "Individual Paper/Project 1"
  a.point_total = 200000
  a.due_date = rand(4).weeks.from_now
  a.has_assignment_submissions = true
  a.release_necessary = true
  a.open_date = "14/02/2013"
  a.grade_scope = "Individual"
end
puts "Individual Project 1 has been posted!"

assignments << Assignment.create! do |a|
  a.course = default_course
  a.assignment_type = assignment_types[4]
  a.name = "Individual Paper/Project 2"
  a.point_total = 300000
  a.due_date = rand(7).weeks.from_now
  a.has_assignment_submissions = true
  a.release_necessary = true
  a.open_date = "14/02/2013"
  a.grade_scope = "Individual"
end
puts "Individual Project 2 has been posted!"

assignments << Assignment.create! do |a|
  a.course = default_course
  a.assignment_type = assignment_types[4]
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
