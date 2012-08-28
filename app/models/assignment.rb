class Assignment < ActiveRecord::Base
  self.inheritance_column = 'something_you_will_not_use'
  
  has_many :grades, :dependent => :destroy
  belongs_to :course
  validates_presence_of :course
  belongs_to :grade_scheme
  has_many :grade_scheme_elements, :through => :grade_scheme
  belongs_to :assignment_type
  has_many :groups
  has_many :assignment_submissions
  accepts_nested_attributes_for :grades
  accepts_nested_attributes_for :assignment_type
  
  delegate :points_predictor_display, :to => :assignment
    attr_accessible :type, :title, :description, :point_total, :due_date, :created_at, :updated_at, :level, :present, :grades_attributes, :assignment_type_id, :grade_scope, :visible, :grade_scheme_id, :required

  scope :individual_assignment, where(:grade_scope => "Individual")
  scope :group_assignment, where(:grade_scope => "Group")
  scope :team_assignment, where(:grade_scope => "Team")

  scope :order, :chronological => 'due_date ASC'

  scope :future, lambda {
    { :conditions => 
      ["assignments.due_date IS NOT nulL AND assignments.due_date >=?", Date.today]
    }
  }
  scope :past, lambda {
    { :conditions => 
      ["assignments.due_date IS NOT nulL AND assignments.due_date <?", Date.today]
    }
  }

  scope :grading_done, where(:assignment_grades.present? == 1)

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
    assignment_grades.where(:raw_score != 0).count
  end

  def type
    assignment_type.try(:name)
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
  
  def past?
    due_date.past?
  end
  
  def future?
    due_date.future?
  end
  
  def fixed?
    points_predictor = "Fixed"
  end
  
  def slider?
    points_predictor = "Slider"
  end
  
  def select?
    points_predictor = "Select List"
  end
  
  #TODO I need this to be either - guessing the assignment type isn't working properly
  def has_levels?
    assignment_type.levels = 1
  end
  
  def binary?
    assignment_type.levels = 0
  end
  
  def mass_grade?
    assignment_type.mass_grade = true
  end
  
  def open?
    #TODO Time comparisons in rails
    Time.now < due_date
  end
  
end
