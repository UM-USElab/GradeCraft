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

Fabricator(:assignment_type_with_student_choice, :from => :assignment_type) do
  user_percentage_set true
end
