class StudentAssignmentTypeWeight < ActiveRecord::Base
  attr_accessible :student, :student_id, :assignment_type, :assignment_type_id, :weight

  include Canable::Ables

  belongs_to :student, :class_name => 'User'
  belongs_to :assignment_type

  validates_presence_of :student, :assignment_type
  validate :course_total_student_weight_allocated

  scope :except_weight, ->(weight) { where('student_assignment_type_weights.id != ?', weight.id) }
  scope :for_course, ->(course) { where(:assignment_type_id => course.assignment_types.pluck(:id)) }

  delegate :course, :to => :assignment_type, :allow_nil => false

  def updatable_by?(user)
    self.student_id == student.id
  end

  def destroyable_by?(user)
    updatable_by?(user)
  end

  def viewable_by?(user)
    updatable_by?(user)
  end

  def total_student_weight
    student.assignment_type_weights.for_course(course).pluck(:weight).sum + (persisted? ? 0 : weight)
  end

  def course_total_student_weight_allocated
    if total_student_weight > course.total_student_weight
      errors.add(:weight, 'Course total student weight exceeded. Please select a lower weight')
    end
  end
end
