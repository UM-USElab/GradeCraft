require 'test_helper'

class GradeTest < ActiveSupport::TestCase
  def grade
    @grade ||= create_grade(:raw_score => 300)
  end

  test "saves course membership's sortable score after creating" do
    assert_equal grade.raw_score, student.sortable_score_for_course(course)
  end

  test "saves course membership's sortable score after updating" do
    grade.update_attributes!(:raw_score => 400)
    assert_equal 400, student.sortable_score_for_course(course)
  end

  test "saves student's sortable score for each course after destroying" do
    grade
    original = student.sortable_score_for_course(course)
    grade.destroy!
    assert_equal original - grade.raw_score, student.sortable_score_for_course(course)
  end

  test "doesn't weight values if student weightable is false" do
    create_student_assignment_type_weight(:weight => 2)
    assert_equal 300, grade.score(student)
  end

  test "calculates correct score with 2x multiplier" do
    @assignment_type = create_assignment_type(:student_weightable => true)
    create_student_assignment_type_weight(:weight => 2)
    assert_equal 600, grade.score(student)
  end

  test "calculates correct score with 6x multiplier" do
    @assignment_type = create_assignment_type(:student_weightable => true)
    create_student_assignment_type_weight(:weight => 6)
    assert_equal 1800, grade.score(student)
  end

  test "doesn't devalue score if not all multipliers have been allocated and there is no weight" do
    @course = create_course(:total_student_weight => 8)
    create_student_assignment_type_weight(:assignment_type => create_assignment_type, :value => 6)
    assert_equal 300, grade.score(student)
  end

  test "calculates devaluation after multipliers have been allocated" do
    @course = create_course(:total_student_weight => 8)
    create_student_assignment_type_weight(:assignment_type => create_assignment_type, :value => 6)
    assert_equal 150, grade.score(student)
  end
end
