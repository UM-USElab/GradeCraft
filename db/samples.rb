user_names = ['Ron Weasley','Fred Weasley','Harry Potter','Hermione Granger','Colin Creevey','Seamus Finnigan','Hannah Abbott','Pansy Parkinson','Zacharias Smith','Blaise Zabini', 'Draco Malfoy', 'Dean Thomas', 'Millicent Bulstrode', 'Terry Boot', 'Ernie Macmillan', 'Vincent Crabbe', 'Gregory Goyle','Lavender Brown','Katie Bell','Parvati Patil','Dennis Creevey','Eloise Midgen','Ritchie Coote','Jack Sloper','Victoria Frobisher','Geoffrey Hooper','Andrew Kirke','Demelza Robins','Cormac McLaggen','Neville Longbottom','Ginny Weasley','Romilda Vane','Natalie McDonald','Jimmy Peakes','Euan Abercrombie','Mary MacDonald','Penelope Clearwater','Roger Davies','Eddie Carmichael','Cho Chang','Marietta Edgecombe','Mandy Brocklehurst','Michael Corner','Stephen Cornfoot','Kevin Entwhistle','Anthony Goldstein','Su Li','Morag McDougal','Padma Patil','Lisa Turpin','Luna Lovegood','Orla Quirke','Stewart Ackerley','Susan Bones','Eleanor Branstone','Owen Cauldwell','Justin Finch-Fletchley','Wayne Hopkins','Megan Jones','Laura Madley','Kevin Whitby','Rose Zeller','Terence Higgs','Adrian Pucey','Tracey Davis','Daphne Greengrass','Theodore Nott','Astoria Greengrass','Malcolm Baddock','Graham Pritchard']
course_names = ['Defense Against the Dark Arts','Muggle Studies','Potions','Transfiguration','Charms','Herbology','Care of Magical Creatures','History of Magic','Divination']
assignment_type_names = ['Hexes','Potions','Wards']
predictor_display = ['Fixed','Select List','Slider']
predictor_description = ['It does not do to dwell on dreams and forget to live, remember that.','As much money and life as you could want!  The two things most human beings would choose above all - the trouble is, humans do have a knack of choosing precisely those things that are worst for them.','It is our choices that show what we truly are, far more than our abilities.','Happiness can be found, even in the darkest of times, if one only remembers to turn on the light.']
semester = %w{Autumn Winter Spring}.sample

puts "\n#{semester} term at Hogwarts has begun!"


# Generate sample courses
courses = []
course_names.each do |course_name|
  courses << Course.create! do |c|
    c.name = course_name
    c.courseno = 101 + courses.count 
    c.year = Date.today.year
    c.semester = semester
  end
end
default_course = courses.first
puts "Conjured #{courses.count} Hogwarts courses for the #{semester} term"

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
  assignment_types = []
  assignment_type_names.each do |assignment_type_name|
    assignment_types << course.assignment_types.create! do |a|
      a.name = assignment_type_name
      a.point_setting = "Individually"
      a.points_predictor_display = predictor_display.sample
      a.max_value = 100 + rand(10)
      a.predictor_description = predictor_description.sample
      a.step_value = 1
    end
  end
  for n in 1..10 do
    assignment = course.assignments.create! do |a|
      a.name = "Assignment #{n}"
      a.due_date = rand(10).weeks.from_now
      a.assignment_type = assignment_types.sample
      a.point_total = 100 + rand(10) * 100
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