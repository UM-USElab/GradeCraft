Fabricator(:student_assignment_type_weight) do
  transient :course
  student
  assignment_type { |attrs| Fabricate(:assignment_type, :course => attrs[:course] ) }
  weight 10
end
