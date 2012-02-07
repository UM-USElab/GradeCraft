Fabricator(:user) do
  first_name 'Test'
  last_name 'User'
  username { sequence(:username) { |i| "testuser#{i}" } }
  email { sequence(:email) { |i| "user#{i}@gradetracker.local" } }
end

Fabricator(:student, :from => :user) do
  role 'student'
end

Fabricator(:student_with_grades, :from => :student) do
  grades!(:count => 2) { |student, i| Fabricate(:grade, :user => student) }
end
