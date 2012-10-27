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
  
  
  
  def student_choice?
    self.user_percentage_set == "true"
  end
  
  #Displays how much the assignment type is worth in the list view
  def weight 
    if percentage_course?
      percentage_course.to_s << "%"
    elsif max_value?
      max_value.to_s << " possible points"
    elsif student_choice?
      "#{course.user_ref}s decide!"
    else
      possible_score.to_s << " possible points"
    end
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
    assignments.any?(&:soon?)
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
  
  def grades_for_student(student)
    self.grades.for_gradeable(student) + self.grades.for_gradeable(student.teams.first)
  end
  
  def score_for_student(student)
    grades_for_student(student).sum { |g| g.score(student) }
  end
  
  def point_totals_by_student_id
    # TODO: Build this method for performance
  end
  
  def point_total_for_student(student)
    assignments.map { |a| a.point_total_for_student(student)}.sum || 0
  end

  def multiplier_for_student(student)
    if student_choice?
      return weight_for_student(student)
    end
    return 1
  end
  
  #assignment type weights by student  
  def weights_by_student_id
    @weights_by_student ||= {}.tap do |weights|
      user_assignment_type_weights.each do |weight|
        if weight.value.blank?
          weight = 1
        else
          weights[weight.user_id] = weight
        end
      end
    end
  end
  
  def present_weight_for_student(student)
    weights_by_student_id[student.id].tap do |weight|
      if weight 
        return true
      else
        return false
      end
    end
  end
  
  def weight_for_student(student)
    weights_by_student_id[student.id].tap do |weight|
      if course.multipliers_spent?(student)
        if weight 
          if weight.value.blank?
            return 0.5
          elsif weight.value == 0
            return 0.5
          else 
            return weight.value
          end
        else
          return 0.5
        end
      else
        if weight 
          if weight.value.blank?
            return 1
          elsif weight.value == 0
            return 1
          else 
            return weight.value
          end
        else
          return 1
        end
      end
    end
  end
  
  def weight_for_assignment_type(student)
    weights_by_student_id[student.id]
  end

end
