class AssignmentType < ActiveRecord::Base
  attr_accessible :due_date_present, :levels, :max_value, :name, :percentage_course, :point_setting, :points_predictor_display, :predictor_description, :resubmission, :universal_point_value, :course_id, :order_placement
  
  belongs_to :course
  belongs_to :grade_scheme
  has_many :assignments
  
  default_scope :order => 'order_placement DESC'
  
  def weight 
    if percentage_course?
      percentage_course
    else 
      max_value
    end
  end
  
end
