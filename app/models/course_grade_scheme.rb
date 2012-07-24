class CourseGradeScheme < ActiveRecord::Base
  attr_accessible :name, :low_range, :high_range, :letter_grade
  belongs_to :course 
  validates_presence_of :course
end
