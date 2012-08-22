Fabricator(:course) do
  name 'Defense Against the Dark Arts'
  courseno 101
  year Date.today.year
  semester %w{Fall Winter Spring Summer}.sample
  theme
end
