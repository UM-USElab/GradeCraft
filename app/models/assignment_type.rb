class AssignmentType < ActiveRecord::Base
  attr_accessible :due_date_present, :levels, :max_value, :name, :percentage_course, :point_setting, :points_predictor_display, :predictor_description, :resubmission, :universal_point_value, :course_id, :order_placement, :user_percentage_set
  
  belongs_to :course
  belongs_to :grade_scheme
  has_many :assignments
  has_many :grades, :through => :assignments
  has_many :user_assignment_type_weights
  
  default_scope :order => 'order_placement ASC'
  
  def weight 
    if percentage_course?
      percentage_course.to_s << "%"
    elsif max_value?
      max_value.to_s << " possible points"
    elsif student_choice?
      "You decide!"
    else
      possible_score
    end
  end
  
  def student_choice?
    user_percentage_set == "true"
  end
  
  def possible_score
    self.assignments.sum(:point_total) || 0
  end

  def slider?
    points_predictor_display == "Slider"
  end
  
  def fixed?
    points_predictor_display == "Fixed"
  end
  
  def select_list?
    points_predictor_display == "Select List"
  end

end
