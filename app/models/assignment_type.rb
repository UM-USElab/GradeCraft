class AssignmentType < ActiveRecord::Base
  attr_accessible :due_date_present, :levels, :max_value, :name, :percentage_course, :point_setting, :points_predictor_display, :predictor_description, :resubmission, :universal_point_value, :course_id, :order_placement, :user_percentage_set, :mass_grade, :score_levels_attributes, :score_level, :mass_grade_type
  
  belongs_to :course
  belongs_to :grade_scheme
  has_many :assignments
  has_many :grades, :through => :assignments
  has_many :user_assignment_type_weights
  has_many :score_levels
  accepts_nested_attributes_for :score_levels, allow_destroy: true
  has_many :user_assignment_type_weights
  
  validates_presence_of :name, :points_predictor_display, :point_setting
  
  default_scope :order => 'order_placement ASC'
  
  def weight 
    if percentage_course?
      percentage_course.to_s << "%"
    elsif max_value?
      max_value.to_s << " possible points"
    elsif student_choice?
      "You decide!"
    else
      possible_score.to_s << " possible points"
    end
  end
  
  def student_choice?
    self.user_percentage_set == "true"
  end
  
  def multiplier_open?
    course.user_weight_amount_close_date > Date.today
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
  
  def select?
    points_predictor_display == "Select List"
  end
  
  def has_levels? 
    levels == true
  end
  
  def has_soon_assignments? 
    #TODO FIX!
    #self.assignments.map(:due_date) => soon?
  end
  
  def assignment_value_sum
    assignments.sum(&:point_total)
  end
  
  def grade_checkboxes?
    mass_grade_type == "Checkbox"
  end 
  
  def grade_select? 
    mass_grade_type == "Select List"
  end 
  
  def grade_radio?
    mass_grade_type =="Radio Buttons"
  end
  
  def assignment_type_scores(student)
    grades.select { |g| g.gradeable_id == student.id }.map(&:score).sum || 0 
  end
  
  # If the student has selected this assignment type to be multiplied, calculate the total value possible
  def assignment_type_multiplied_value
    (weights_for_assignment_type_id(assignment_type).try(:value) || 0.5)  * assignment_type.assignment_value_sum
  end
  
  def point_totals_by_student_id
    # TODO: Build this method for performance
  end
  
  def point_total_for_student(student)
    assignments.map { |a| a.point_total_for_student(student) }.sum || 0
  end

  def score_for_student(student)
    grades.select { |g| g.gradeable_id == student.id && g.gradeable_type == 'User' }.sum(&:score) || 0
  end
  
  def multiplier_for_student(student)
    if student_choice?
      return weight_for_student(student)
    end
    return 1
  end
  
    # If the student has selected this assignment type calculate their score
  def assignment_type_multiplied_score(assignment_type)
    assignment_type_score(assignment_type) * (weights_for_assignment_type_id(assignment_type).try(:value) || 0.5) 
  end
  

  def assignment_type_multiplier(assignment_type)
    (weights_for_assignment_type_id(assignment_type).try(:value) || 0.5)
  end
  
  #assignment type weights by student  
  def weights_by_student_id
    @weights_by_student ||= {}.tap do |weights|
      user_assignment_type_weights.each do |weight|
        weights[weight.user_id] = weight
      end
    end
  end
  
  def weight_for_student(student)
    weights_by_student_id[student.id].tap do |weight|
      if weight
        return weight.value
      else
        return course.multipliers_spent?(student) ? 0.5 : 1
      end
    end
  end
  

end
