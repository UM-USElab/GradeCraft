require 'test_helper'

class AssignmentTypeTest < ActiveSupport::TestCase
  setup do
    @course = Fabricate(:course, :user_weight_amount => 6)
    @assignment_type = Fabricate(:assignment_type_with_student_choice, :course => @course)
    @student = Fabricate(:student, :course => [@course])
    @assignments = [300, 500].map do |n|
      Fabricate(:assignment, :assignment_type => @assignment_type, :point_total => n)
    end
  end

  test "calculates points total for student" do
    assert_equal 800, @assignment_type.point_total_for_student(@student)
  end

  test "calculates 2x point total for student" do
    Fabricate(:user_assignment_type_weight, :user => @student, :assignment_type => @assignment_type, :value => 2)
    assert_equal 1600, @assignment_type.point_total_for_student(@student)
  end

  test "calculates score for student" do
    Fabricate(:grade, :assignment => @assignments.first, :gradeable => @student, :raw_score => 250)
    Fabricate(:grade, :assignment => @assignments.last, :gradeable => @student, :raw_score => 400)
    assert_equal 650, @assignment_type.score_for_student(@student)
  end

  test "calculates 2x score for student" do
    Fabricate(:grade, :assignment => @assignments.first, :gradeable => @student, :raw_score => 250)
    Fabricate(:grade, :assignment => @assignments.last, :gradeable => @student, :raw_score => 400)
    Fabricate(:user_assignment_type_weight, :user => @student, :assignment_type => @assignment_type, :value => 2)
    assert_equal 1300, @assignment_type.score_for_student(@student)
  end

  #is the assignment type student weight configurable?

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
