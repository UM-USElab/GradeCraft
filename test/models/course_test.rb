require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  test "user_term returns default Player if no term set" do
    assert_equal "Player", course.user_term
  end

  test "team_term returns default Team if no term set" do
    assert_equal "Team", course.team_term
  end

  test "group_term returns default Group if no term set" do
    assert_equal "Group", course.group_term
  end

  test "section_leader_term returns default Team Leader if no term set" do
    assert_equal "Team Leader", course.section_leader_term
  end

  test "multiplier_term returns default Mulitplier if no term set" do
    assert_equal "Multiplier", course.multiplier_term
  end

  test "point total" do
    create_assignments(2) # point totals: 300, 500
    assert_equal 800, course.total_points
  end

  test "point total with past assignment" do
    create_assignments(3) # point totals: future, 300; past, 500; future, 700
    assert_equal 500, course.total_points(true)
  end

  def course
    @course ||= Fabricate.build(:course)
  end
end
