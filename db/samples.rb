user_names = ['Ron Weasley','Fred Weasley','Harry Potter','Hermione Granger','Colin Creevey','Seamus Finnigan','Hannah Abbott','Pansy Parkinson','Zacharias Smith','Blaise Zabini', 'Draco Malfoy', 'Dean Thomas', 'Millicent Bulstrode', 'Terry Boot', 'Ernie Macmillan', 'Vincent Crabbe', 'Gregory Goyle','Lavender Brown','Katie Bell','Parvati Patil','Dennis Creevey','Eloise Midgen','Ritchie Coote','Jack Sloper','Victoria Frobisher','Geoffrey Hooper','Andrew Kirke','Demelza Robins','Cormac McLaggen','Neville Longbottom','Ginny Weasley','Romilda Vane','Natalie McDonald','Jimmy Peakes','Euan Abercrombie','Mary MacDonald','Penelope Clearwater','Roger Davies','Eddie Carmichael','Cho Chang','Marietta Edgecombe','Mandy Brocklehurst','Michael Corner','Stephen Cornfoot','Kevin Entwhistle','Anthony Goldstein','Su Li','Morag McDougal','Padma Patil','Lisa Turpin','Luna Lovegood','Orla Quirke','Stewart Ackerley','Susan Bones','Eleanor Branstone','Owen Cauldwell','Justin Finch-Fletchley','Wayne Hopkins','Megan Jones','Laura Madley','Kevin Whitby','Rose Zeller','Terence Higgs','Adrian Pucey','Tracey Davis','Daphne Greengrass','Theodore Nott','Astoria Greengrass','Malcolm Baddock','Graham Pritchard']
course_names = ['Defense Against the Dark Arts','Muggle Studies','Potions','Transfiguration','Charms','Herbology','Care of Magical Creatures','History of Magic','Divination']
assignment_type_names = ['Hexes','Potions','Wards']
predictor_display = ['Fixed','Select List','Slider']
predictor_description = ['It does not do to dwell on dreams and forget to live, remember that.','As much money and life as you could want!  The two things most human beings would choose above all - the trouble is, humans do have a knack of choosing precisely those things that are worst for them.','It is our choices that show what we truly are, far more than our abilities.','Happiness can be found, even in the darkest of times, if one only remembers to turn on the light.']
badge_names = ['Dream Interpreter','Inner Eye','Patronus Producer','Cheerful Charmer','Invisiblity Cloak','Marauders Map','Lumos','Rune Reader','Tea Leaf Guru','Wizard Chess Grand Master','Green Thumb','Gamekeeper','Seeker','Alchemist','Healer','Parseltongue','House Cup']
team_names = ['Gryffindor','Slytherin','Hufflepuff','Ravenclaw']
semester = %w{Autumn Winter Spring}.sample
badge_icons = ['/badges/pos101/above_and_beyond.png','/badges/pos101/always_learning.png','/badges/pos101/awesome_aggregator.png','/badges/pos101/concentrator.png','/badges/pos101/courageous_failure.png','/badges/pos101/early_bird_special.png','/badges/pos101/examination_expert.png','/badges/pos101/gaining_experience.png','/badges/pos101/gamer.png','/badges/pos101/great_critic.png','/badges/pos101/learning_from_mistakes.png','/badges/pos101/level_one.png','/badges/pos101/participatory_democrat.png','/badges/pos101/personal.png','/badges/pos101/practice_makes_perfect.png','/badges/pos101/presentation_of_self.png','/badges/pos101/public_speaker.png']
grade_scheme_hash = { [0,59] => 'F', [60,69] => 'D', [70,79] => 'C', [80,89] => 'B', [90, 100] => 'A' }

puts "\n#{semester} term at Hogwarts has begun!"

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
    b.visible = 1
  end
end
puts "Did someone need motivation? We found these badges in the Room of Requirements..."


# Generate sample courses
courses = []
course_names.each do |course_name|
  courses << Course.create! do |c|
    c.name = course_name
    c.courseno = 101 + courses.count 
    c.year = Date.today.year
    c.semester = semester
    c.team_setting = true
    c.team_term = "House"
    c.user_term = "Wizard"
    c.section_leader_term = "Prefect"
  end
end
default_course = courses.first
puts "Conjured #{courses.count} Hogwarts courses for the #{semester} term"

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
    u.courses = [default_course] + (courses.sample(rand(courses.count)) - [default_course])
  end
end
puts "Generated #{students.count} unruly students"

# Generate sample admin
User.create! do |u|
  u.username = 'albus'
  u.first_name = 'Albus'
  u.last_name = 'Dumbledore'
  u.role = 'admin'
  u.email = 'dumbledore@hogwarts.edu'
  u.password = 'fawkes'
  u.courses = courses
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
  u.courses = courses
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
  u.courses = courses
end
puts "Percy Weasley has arrived on campus, on time as usual"


courses.each do |course|
  teams = []
  team_names.each do |team_name|
    teams << course.teams.create! do |t|
      t.name = team_name
    end
  end
  students.each do |student|
    TeamMembership.create! do |tm|
      tm.user = student
      tm.team = teams.sample
    end
  end
  assignment_types = []
  assignment_type_names.each do |assignment_type_name|
    assignment_types << course.assignment_types.create! do |a|
      a.name = assignment_type_name
      a.point_setting = "Individually"
      a.points_predictor_display = predictor_display.sample
      a.max_value = 100 * rand(10)
      a.predictor_description = predictor_description.sample
      a.step_value = 1
    end
  end
  for n in 1..10 do
    assignment = course.assignments.create! do |a|
      a.name = "Assignment #{n}"
      a.due_date = rand(10).weeks.from_now
      a.assignment_type = assignment_types.sample
      a.point_total = (100 + rand(10)) * 100
    end
    students.each do |student|
      Grade.create! do |g|
        g.assignment = assignment
        g.gradeable = student
        g.raw_score = assignment.point_total * ((6 + rand(5)) / 10.0)
        g.raw_score = assignment.point_total if student.name == 'Hermione Granger'
      end
      student.save
    end
  end
end
puts "Assigned an impossible workload for each course (impossible, that is, unless you possess a Time-Turner)"

course_grade_scheme = CourseGradeScheme.new
grade_scheme_hash.each do |range,name|
  course_grade_scheme.course_grade_scheme_elements.new do |e|
    e.name = name
    e.low_range = range.first
    e.high_range = range.last
  end
end
course_grade_scheme.courses = Course.all
course_grade_scheme.save!
puts "Installed a boring grade scheme for each course"
