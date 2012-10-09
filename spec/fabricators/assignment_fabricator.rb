Fabricator(:assignment) do
  name 'Test Assignment'
  grade_scope 'Individual'
  course
end

Fabricator(:weighted_assignment, :from => :assignment) do
  assignment_type { Fabricate(:weighted_assignment_type) }
end
