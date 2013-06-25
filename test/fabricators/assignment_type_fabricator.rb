Fabricator(:assignment_type) do
  name 'Test Assignment Type'
  point_setting 'Individually'
  levels ""
  points_predictor_display 'Slider'
  resubmission ""
  max_value ""
  percentage_course ""
  predictor_description "MyString"
end

# Generates an assignment type with assignments (pass :n, default is 2). Each
# assignment will have a different point total, starting with 300 and
# increasing by 200 for each additional assignment generated.
Fabricator(:assignment_type_with_assignments, :from => :assignment_type) do
  transient :n => 2
  after_create do |assignment_type, transients|
    transients[:n].times { |i| Fabricate(:assignment, :assignment_type => assignment_type, :point_total => i * 200 + 300) }
  end
end
