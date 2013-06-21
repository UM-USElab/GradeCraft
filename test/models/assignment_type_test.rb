require 'test_helper'

class AssignmentTypeTest < ActiveSupport::TestCase
  # Assignment point totals: [300, 500]
  test "calculates point total for student" do
    assert_equal 800, assignment_type.point_total_for_student(student)
  end

  test "multiplier is 1 if not student weightable" do
    assert_equal 1, assignment_type.multiplier_for_student(student)
  end

  # Weight: 2
  test "calculates weighted point total for student" do
    Fabricate(:user_assignment_type_weight, :user => student, :assignment_type => assignment_type)
    assert_equal 1600, assignment_type.point_total_for_student(student)
  end

  # Grades: [200, 400]
  test "calculates score for student" do
    @student = Fabricate(:student_with_grades, :assignments => assignment_type.assignments)
    assert_equal 600, assignment_type.score_for_student(student)
  end

  # Grades: [200, 400], weight: 2
  test "calculates 2x score for student" do
    @student = Fabricate(:student_with_grades, :assignments => assignment_type.assignments)
    Fabricate(:user_assignment_type_weight, :user => student, :assignment_type => assignment_type)
    assert_equal 1200, assignment_type.score_for_student(student)
  end

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

  # Lazy loaded objects. These can be overridden by setting the instance
  # variable before calling the method.
  def assignment_type
    @assignment_type ||= Fabricate(:assignment_type_with_assignments, :course => course)
  end

  def course
    @course ||= Fabricate(:course)
  end

  def student
    @student ||= Fabricate(:student)
  end
end
