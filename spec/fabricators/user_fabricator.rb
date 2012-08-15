Fabricator(:user) do
  first_name 'Test'
  last_name 'User'
  username { sequence(:username) { |i| "testuser#{i}" } }
  email { sequence(:email) { |i| "user#{i}@gradetracker.local" } }
end

Fabricator(:student, :from => :user) do
  role 'student'
  courses(count: 1)
end
