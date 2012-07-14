class AssignmentType < ActiveRecord::Base
  attr_accessible :due_date, :levels, :max_value, :name, :percentage_course, :point_setting, :points_predictor_display, :predictor_description, :resubmission, :universal_point_value
  
  belongs_to :course
  has_many :assignments
  
end
