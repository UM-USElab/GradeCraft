Fabricator(:user) do
  first_name 'Test'
  last_name 'User'
  username { Fabricate.sequence(:username) { |i| "testuser#{i}" } }
  email { Fabricate.sequence(:email) { |i| "user#{i}@gradetracker.local" } }
end

Fabricator(:student, :from => :user) do
  role 'student'
  courses(:count => 1)
end

Fabricator(:student_with_grades, :from => :student) do
  grades { [Fabricate(:grade)] }
end
