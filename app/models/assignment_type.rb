class AssignmentType < ActiveRecord::Base
  attr_accessible :due_date_present, :levels, :max_value, :name,
    :percentage_course, :point_setting, :points_predictor_display,
    :predictor_description, :resubmission, :universal_point_value, :course,
    :course_id, :order_placement, :student_weightable, :mass_grade,
    :score_levels_attributes, :score_level, :mass_grade_type, :course

  belongs_to :course
  belongs_to :grade_scheme
  has_many :assignments
  has_many :grades, :through => :assignments
  has_many :student_weights, :class_name => 'StudentAssignmentTypeWeight'
  has_many :score_levels
  accepts_nested_attributes_for :score_levels, allow_destroy: true

  validates_presence_of :name, :points_predictor_display, :point_setting

  #default_scope :order => 'order_placement ASC'

  #Displays how much the assignment type is worth in the list view
  def weight
    if percentage_course?
      percentage_course.to_s << "%"
    elsif max_value?
      max_value.to_s << " possible points"
    elsif student_weightable?
      "#{course.user_term}s decide!"
    else
      possible_score.to_s << " possible points"
    end
  end

  def multiplier_open?
    course.student_weight_close_date > Date.today
  end

  # the next two methods should be consolidated into one
  def possible_score
    self.assignments.sum(:point_total) || 0
  end

  def assignment_value_sum
    assignments.sum(&:point_total)
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

  def mass_grade?
    mass_grade == true
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

  def group_grades_for_student(student)
    grades = []
    student.groups.each do |group|
      grades += self.grades.where(:gradeable => group)
    end
    grades
  end

  def individual_grades_for_student(student)
    self.grades.where(:gradeable => student)
  end

  def team_grades_for_student(student)
    self.grades.where(:gradeable => student.teams.first)
  end

  def grades_for_student(student)
    individual_grades_for_student(student) + ((group_grades_for_student(student) if student.groups.present?) || [])
    #individual_grades_for_student(student) + team_grades_for_student(student) + ((group_grades_for_student(student) if student.groups.present?) || [])
  end


  def score_for_student(student)
    grades_for_student(student).sum { |g| g.score(student) }
  end

  def point_totals_by_student_id
    # TODO: Build this method for performance
  end

  def point_total_for_student(student)
    assignments.to_a.sum { |a| a.point_total_for_student(student) }
  end

  def multiplier_for_student(student)
    student_weightable? ? weight_for_student(student) : 1
  end

  #assignment type weights by student
  def weights_by_student_id
    @weights_by_student ||= {}.tap do |weights|
      student_weights.each do |student_weight|
        if student_weight.blank?
          weight = 1
        else
          weights[student_weight.student_id] = student_weight
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
    weights_by_student_id[student.id].tap do |student_weight|
      if course.multipliers_spent?(student)
        if student_weight
          if student_weight.weight.blank?
            return 0.5
          elsif student_weight.weight == 0
            return 0.5
          else
            return student_weight.weight
          end
        else
          return 0.5
        end
      else
        if student_weight
          if student_weight.weight.blank?
            return 1
          elsif student_weight.weight == 0
            return 1
          else
            return student_weight.weight
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
