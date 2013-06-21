require 'test_helper'
require 'helpers/lazy_loaded_fabricators'

class UserAssignmentTypeWeightTest < ActiveSupport::TestCase
  include LazyLoadedFabricators

  test "calculates total student weight when current weight is persisted" do
    @weight = Fabricate(:user_assignment_type_weight, :course => course, :user => student, :value => 3)
    assert_equal 6, @weight.total_student_weight
  end

  test "calculates total student weight when current weight is not persisted" do
    @weight = Fabricate.build(:user_assignment_type_weight, :course => course, :user => student, :value => 3)
    assert_equal 6, @weight.total_student_weight
  end

  private

  def student
    @student ||= Fabricate(:student_with_weights, :course => course)
  end
end
