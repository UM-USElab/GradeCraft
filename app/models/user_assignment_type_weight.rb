class UserAssignmentTypeWeight < ActiveRecord::Base
  attr_accessible :user, :user_id, :assignment_type, :assignment_type_id, :value

  include Canable::Ables

  belongs_to :user
  belongs_to :assignment_type

  validates_presence_of :user_id, :assignment_type_id
  validate :course_max_student_weight_not_exceeded, :max_value_per_at, :min_value_per_at

  scope :except_weight, ->(weight) { where('user_assignment_type_weights.id != ?', weight.id) }
  scope :for_course, ->(course) { where(:assignment_type_id => course.assignment_types.pluck(:id)) }

  delegate :course, :to => :assignment_type, :allow_nil => false
  
  def updatable_by?(user)
    creator == user
  end

  def destroyable_by?(user)
    updatable_by?(user)
  end

  def viewable_by?(user)
    user_id == user.id
  end
  
  def max_value_per_at
    if value > course.max_size
      errors.add(:value, "Max value for this assignment type has been exceed. Please set a lower value.")
    end
  end
  
  def min_value_per_at
    if value < course.min_size
      errors.add(:value, "The value for this assignment type is too low. Please set a higher value.")
    end
  end

  def total_student_weight
    user.weights_for_course(course).pluck(:value).sum + (persisted? ? 0 : value)
  end

  def course_max_student_weight_not_exceeded
    if total_student_weight > course.max_student_weight
      errors.add(:value, 'Course max student weight exceeded. Please select a lower value')
    end
  end
end
