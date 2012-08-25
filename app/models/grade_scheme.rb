class GradeScheme < ActiveRecord::Base
  has_many :assignments
  belongs_to :course
  has_many :grade_scheme_elements
  
  attr_accessible :created_at, :updated_at, :name, :course_id
  
end
