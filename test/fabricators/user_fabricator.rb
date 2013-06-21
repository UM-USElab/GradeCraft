Fabricator(:user) do
  first_name 'Test'
  last_name 'User'
  username { Fabricate.sequence(:username) { |i| "testuser#{i}" } }
  email { Fabricate.sequence(:email) { |i| "user#{i}@gradecraft.local" } }
end

Fabricator(:student, :from => :user) do
  transient :course
  role 'student'
  before_create do |student, transients|
    student.courses = [transients[:course] || Fabricate(:course)]
  end
end

Fabricator(:student_with_weights, :from => :student) do
  transient :n => 2
  after_create do |student, transients|
    transients[:n].times do |i|
      Fabricate(:user_assignment_type_weight, :user => student, :value => i + 1) do
        course transients[:course]  if transients[:course]
      end
    end
  end
end

Fabricator(:student_with_grades, :from => :student) do
  transient :assignments => []
  after_create do |student, transients|
    transients[:assignments].each do |assignment|
      Fabricate(:grade, :gradeable => student, :assignment => assignment, :raw_score => assignment.point_total - 100)
    end
  end
end
