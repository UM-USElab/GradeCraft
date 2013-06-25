Fabricator(:grade) do
  assignment
  gradeable { Fabricate(:student) }
  raw_score { |attrs| attrs[:assignment].point_total - 100 }
end
