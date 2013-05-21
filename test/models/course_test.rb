require 'test_helper'

class CourseTest < ActiveSupport::TestCase

  test "user_term returns default Player if no term set" do 
    @course = Course.new 
    assert_equal "Player", @course.user_term
  end  
  
end