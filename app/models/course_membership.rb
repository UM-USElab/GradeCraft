class CourseMembership < ActiveRecord::Base
  belongs_to :course
  belongs_to :user

  scope :for_course, ->(course) { where(:course => course) }
end
