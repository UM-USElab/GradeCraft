class GradeScheme < ActiveRecord::Base
  belongs_to :assignment
  
  attr_accessible :assignment_id, :created_at, :updated_at, :grade_name, :range_bottom, :range_top
  
  
end
