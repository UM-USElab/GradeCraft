Fabricator(:grade) do
  user
  assignment
  score { rand(1000) }
end
