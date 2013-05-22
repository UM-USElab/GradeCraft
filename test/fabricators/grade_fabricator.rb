Fabricator(:grade) do
  gradeable { Fabricate(:user) }
  assignment
  raw_score { rand(1000) }
end
