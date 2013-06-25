Fabricator(:assignment) do
  name 'Test Assignment'
  grade_scope 'Individual'
  point_total { sequence(:point_total) { |n| n * 100 } }
  assignment_type
  due_date { sequence(:due_date) { |n| (n.even? ? n : -n).days.from_now } }  # if i is even, due i days in the future; otherwise, due i days in the past.
end

Fabricator(:past_assignment, :from => :assignment) do
  due_date 3.days.ago
end
