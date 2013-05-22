Fabricator(:badge_set) do
  name { sequence(:name) { |i| "Badge Set #{i}" } } 
end
