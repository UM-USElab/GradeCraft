Fabricator(:course) do
  name 'Defense Against the Dark Arts'
  courseno 101
  year Date.today.year
  semester %w{Fall Winter Spring Summer}.sample
  theme
  team_setting true
  group_setting true
  total_student_weight 60
end

Fabricator(:course_with_assignments, :from => :course) do
  assignments(:count => 3) do |attrs, i|
    Fabricate(:assignment,
      :point_total => i * 10, # 10, 20, 30, etc.
      :due_date => (i.even? ? -i : i).days.from_now # if i is even, due i days in the future; otherwise, due i days in the past.
     )
  end
end
