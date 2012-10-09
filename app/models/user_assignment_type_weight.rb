class UserAssignmentTypeWeight < ActiveRecord::Base
  attr_accessible :user_id, :assignment_type_id, :value
  
  belongs_to :user
  belongs_to :assignment_type
  
  validates_presence_of :user_id, :assignment_type_id, :value
  validate :course_max_value_not_exceeded

  def course_max_value_not_exceeded
    all_other_weights = assignment_type.user_assignment_type_weights.where(:user_id => user) - [self]
    if all_other_weights.sum(&:value) + self.value > assignment_type.course.user_weight_amount
      errors.add(:value, 'Course max value exceeded. Please select a lower value')
    end
  end
end
