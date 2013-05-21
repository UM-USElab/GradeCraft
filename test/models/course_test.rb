require 'test_helper'

class CourseTest < ActiveSupport::TestCase

  test "user_term returns default Player if no term set" do 
    @course = Course.new 
    assert_equal "Player", @course.user_term
  end
  
  test "team_term returns default Team if no term set" do 
    @course = Course.new 
    assert_equal "Team", @course.team_term 
  end
  
  test "group_term returns default Group if no term set" do 
    @course = Course.new 
    assert_equal "Group", @course.group_term
  end
  
  test "section_leader_term returns default Team Leader if no term set" do 
    @course = Course.new 
    assert_equal "Team Leader", @course.section_leader_term 
  end
  
  test "multiplier_term returns default Mulitplier if no term set" do 
    @course = Course.new 
    assert_equal "Multiplier", @course.multiplier_term
  end
  
  test "point total" do 
    @course = Fabricate(:course_with_assignments)
    assert_equal 150, @course.total_points
  end
  
  test "point total with past assignment" do 
    @course = Fabricate(:course_with_assignments)
    assert_equal 50, @course.total_points(true)
  end
  
end