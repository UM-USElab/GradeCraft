require 'test_helper'

class AssignmentTypeTest < ActiveSupport::TestCase
  test "calculates point total for student" do
    create_assignments(2) # point totals: 300, 500
    assert_equal 800, assignment_type.point_total_for_student(student)
  end

  test "multiplier is 1 if not student weightable" do
    assert_equal 1, assignment_type.multiplier_for_student(student)
  end

  test "calculates weighted point total for student" do
    @assignment_type = create_assignment_type(:student_weightable => true)
    create_assignments(2) # point totals: 300, 500
    create_student_assignment_type_weight(:weight => 2)
    assert_equal 1600, assignment_type.point_total_for_student(student)
  end

  test "calculates score for student" do
    create_grades(2) # raw scores: 200, 400
    assert_equal 600, assignment_type.score_for_student(student)
  end

  test "calculates 2x score for student" do
    @assignment_type = create_assignment_type(:student_weightable => true)
    create_grades(2) # raw scores: 200, 400
    create_student_assignment_type_weight(:weight => 2)
    assert_equal 1200, assignment_type.score_for_student(student)
  end

  # Max weight for any particular assignment type
  # Total weight equals total available weight

  #what is the assignment type weight structure for the course

  #what date does the multiplier need to be set by

  #how will this assignment type be displayed in the predictor?

  #how many total points is this assignment type worth?

  #does this assignment type have levels?

  #does this assignment type have assignments coming up soon?

  #is this assignment type mass gradeable? 

  #how is this assignment graded?

  #calculating group grades for students

  #calculating individual grades for students

  #calculating team grades for students

  #calculating score for student

  #multiplier for student
end
