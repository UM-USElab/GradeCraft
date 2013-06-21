require 'test_helper'

class UserAssignmentTypeWeightTest < ActiveSupport::TestCase
  include LazyLoadedFabricators
  include ValidAttribute::Method

  test "calculates total student weight when current weight is persisted" do
    @weight = Fabricate(:user_assignment_type_weight, :course => course, :user => student, :value => 3)
    assert_equal 6, @weight.total_student_weight
  end

  test "calculates total student weight when current weight is not persisted" do
    @weight = Fabricate.build(:user_assignment_type_weight, :course => course, :user => student, :value => 3)
    assert_equal 6, @weight.total_student_weight
  end

  test "adds an error when total student weight exceeds course max student weight" do
    @course = Fabricate(:course, :max_student_weight => 2)
    @weight = Fabricate.build(:user_assignment_type_weight, :course => course)
    assert_must have_valid(:value).when(2), @weight
    assert_wont have_valid(:value).when(3), @weight
  end

  private

  def student
    @student ||= Fabricate(:student_with_weights, :course => course)
  end
end
