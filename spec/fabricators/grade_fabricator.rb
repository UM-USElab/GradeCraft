Fabricator(:grade) do
  user { Fabricate(:user) }
  assignment { Fabricate(:assignment) }
end
