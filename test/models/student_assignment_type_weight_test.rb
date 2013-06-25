require 'test_helper'

class StudentAssignmentTypeWeightTest < ActiveSupport::TestCase
  include ValidAttribute::Method

  test "calculates total student weight when current weight is persisted" do
    create_student_assignment_type_weight :weight => 1
    create_student_assignment_type_weight :weight => 2
    @student_assignment_type_weight = create_student_assignment_type_weight :weight => 3
    assert_equal 6, student_assignment_type_weight.total_student_weight
  end

  test "calculates total student weight when current weight is not persisted" do
    create_student_assignment_type_weight :weight => 1
    create_student_assignment_type_weight :weight => 2
    @weight = Fabricate.build :student_assignment_type_weight, :student => student, :assignment_type => assignment_type, :weight => 3
    assert_equal 6, @weight.total_student_weight
  end

  test "adds an error when total student weight exceeds course total student weight" do
    @course = create_course(:total_student_weight => 2)
    @weight = Fabricate.build :student_assignment_type_weight, :student => student, :assignment_type => assignment_type, :weight => 3
    assert_must have_valid(:weight).when(2), @weight
    assert_wont have_valid(:weight).when(3), @weight
  end
end
