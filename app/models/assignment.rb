class Assignment < ActiveRecord::Base
  self.inheritance_column = 'something_you_will_not_use'
  
  has_many :grades, :dependent => :destroy
  belongs_to :course
  validates_presence_of :course
  belongs_to :grade_scheme
  has_many :grade_scheme_elements, :through => :grade_scheme
  belongs_to :assignment_type
  has_many :groups
  has_many :group_memberships, :through => :group_memberships
  has_many :users, :through => :grades
  belongs_to :badge_set
  has_many :assignment_submissions
  accepts_nested_attributes_for :grades
  accepts_nested_attributes_for :assignment_type
  has_many :score_levels  
  accepts_nested_attributes_for :score_levels, allow_destroy: true
  
  delegate :points_predictor_display, :to => :assignment
  
  validates_presence_of :name, :grade_scope
    attr_accessible :type, :name, :description, :point_total, :due_date, :created_at, :updated_at, :level, :present, :grades_attributes, :assignment_type_id, :grade_scope, :visible, :grade_scheme_id, :required, :open_time, :has_assignment_submissions, :student_logged_button_text, :student_logged, :badge_set_id, :release_necessary, :score_levels_attributes, :open_date, :close_time

  scope :individual_assignment, where(:grade_scope => "Individual")
  scope :group_assignment, where(:grade_scope => "Group")
  scope :team_assignment, where(:grade_scope => "Team")

  scope :order, :chronological => 'due_date ASC'

  scope :future, lambda {
    { :conditions => 
      ["assignments.due_date IS NOT NULL AND assignments.due_date >=?", Date.today]
    }
  }
  scope :past, lambda {
    { :conditions => 
      ["assignments.due_date IS NOT NULL AND assignments.due_date <?", Date.today]
    }
  }

  scope :grading_done, where(:assignment_grades.present? == 1)
  
  
  #grades per role  
  def grades_by_gradeable_id
    @grades_by_gradeable_id ||= grades.group_by { |g| [g.gradeable_type,g.gradeable_id] }
  end

  def grade_for_student(student)
    grades_by_gradeable_id[['User',student.id]].try(:first)
  end
  
  def grade_for_group(group)
    grades_by_gradeable_id[['Group',group.id]].try(:first)
  end 
  
  def grade_for_team(team)
    grades_by_gradeable_id[['Team',team.id]].try(:first)
  end

  #submissions per role
  def submissions_by_submittable_id
    @submissions_by_submittable_id || assignment_submissions.group_by { |s| [s.submittable_type,s.submittable_id] }
  end
  
  def submission_for_student(student)
    submissions_by_submittable_id[['User',student.id]].try(:first)
  end
  
  
  def submission_for_group(group)
    submissions_by_submittable_id[['Group',group.id]].try(:first)
  end
  
  def submission_for_team(team)
    submissions_by_submittable_id[['Team',team.id]].try(:first)
  end
  
  
  def assignment_submissions_by_assignment_id
    @assignment_submissions_by_assignment_id ||= assignment_submissions.group_by(&:assignment_id)
  end

  def assignment_submissions_for_assignment(assignment)
    assignment_submissions_by_assignment_id[assignment.id].try(:first)
  end


  def assignment_grades
    Grade.where(:assignment_id => id)
  end
  
  def high_score
    assignment_grades.maximum(:raw_score)
  end
  
  def low_score
    assignment_grades.minimum(:raw_score)
  end

  def average 
    assignment_grades.average(:raw_score).try(:round)
  end  
  
  def assignment_grades_attempted
    #assignment_grades.where(:raw_score != 0).count
  end

  def type
    assignment_type.try(:name)
  end
  
  def release_necessary?
    release_necessary == true 
  end
  
  def is_individual?
    !['Group','Team'].include? grade_scope
  end
  
  def has_groups?
    grade_scope=="Group"
  end
  
  def has_teams?
    grade_scope=="Team"
  end
  
  def is_visible?
    visible == "true"
  end
  
  def point_total
    super || assignment_type.universal_point_value 
  end
  
  def past?
    due_date != nil && due_date < Date.today
  end
  
  def future?
    due_date != nil && due_date >= Date.today
  end
  
  def soon?
    if due_date?
      due_date < Time.now + 7.days
    end
  end
  
  def fixed?
    points_predictor = "Fixed"
  end
  
  def has_assignment_submissions? 
    has_assignment_submissions == true
  end
  
  def slider?
    points_predictor = "Slider"
  end
  
  def select?
    points_predictor = "Select List"
  end
  
  def self_gradeable?
    student_logged == true
  end
  
  def is_required?
    required == true
  end
  
  def has_levels?
    assignment_type.levels == true
  end
  
  def mass_grade?
    assignment_type.mass_grade = true
  end
  
  def grade_checkboxes?
    assignment_type.mass_grade_type == "Checkbox"
  end 
  
  def grade_select? 
    assignment_type.mass_grade_type == "Select List"
  end 
  
  def grade_radio?
    assignment_type.mass_grade_type =="Radio Buttons"
  end
  
  def open?
    (open_date !=nil && open_date < Time.now) && (due_date != nil && due_date > Time.now)
  end
    
  def score_for_grade(grade)
   grade.try(:score) || ""
  end
  
  def grade_level(grade)
    grade_scheme.try(:grade_level, score_for_grade(grade)) || "--"
  end  
  
end
