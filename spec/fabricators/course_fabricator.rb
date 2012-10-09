Fabricator(:course) do
  name 'Defense Against the Dark Arts'
  courseno 101
  year Date.today.year
  semester %w{Fall Winter Spring Summer}.sample
  theme
  team_setting true
  group_setting true
end

Fabricator(:course_with_user_weight, :from => :course) do
  user_weight_amount 6
end
