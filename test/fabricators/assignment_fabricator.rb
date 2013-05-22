Fabricator(:assignment) do
  name 'Test Assignment'
  grade_scope 'Individual'
  course
  point_total 50
end

Fabricator(:weighted_assignment, :from => :assignment) do
  assignment_type { Fabricate(:weighted_assignment_type) }
end


Fabricator(:past_assignment, :from => :assignment) do
  due_date 3.days.ago
end
