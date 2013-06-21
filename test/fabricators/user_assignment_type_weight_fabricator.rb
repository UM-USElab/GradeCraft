Fabricator(:user_assignment_type_weight) do
  transient :course
  user
  assignment_type { |attrs| Fabricate(:assignment_type, :course => attrs[:course] ) }
  value 2
end
