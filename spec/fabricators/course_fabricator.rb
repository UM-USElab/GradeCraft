Fabricator(:course) do
  name 'Defense Against the Dark Arts'
  courseno 101
  year Date.today.year
  semester %w{Fall Winter Spring Summer}.sample
  theme
  team_setting true
  group_setting true
end

Fabricator(:course_with_assignments, :from => :course) do 
  after_create do |course|
    debugger
    [Fabricate(:assignment, :course => course), Fabricate(:assignment, :course => course), Fabricate(:past_assignment, :course => course)]
  end
end