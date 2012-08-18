Fabricator(:grade) do
  gradeable { Fabricate(:user) }
  assignment
  score { rand(1000) }
end
