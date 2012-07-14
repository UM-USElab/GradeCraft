class CourseGradeScheme < ActiveRecord::Base
  attr_accessible :name
  belongs_to :course 
  validates_presence_of :course
end
