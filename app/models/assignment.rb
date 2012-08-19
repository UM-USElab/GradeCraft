class Assignment < ActiveRecord::Base
  self.inheritance_column = 'something_you_will_not_use'
  
  has_many :assignment_grades, :dependent => :destroy
  belongs_to :course
  belongs_to :grade_schemes
  validates_presence_of :course
  belongs_to :assignment_type
  has_many :groups
  accepts_nested_attributes_for :assignment_grades
    attr_accessible :type, :title, :description, :point_total, :due_date, :created_at, :updated_at, :level, :present, :grades_attributes, :assignment_type_id, :grade_scope, :visible, :grade_scheme_id


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

  def mass_gradeable?
    true
  end

  def assignment_grades
    Grade.where(:assignment_id => id)
  end
  
  def high_score
    assignment_grades.maximum(:score)
  end
  
  def low_score
    assignment_grades.minimum(:score)
  end

  def average 
    assignment_grades.average(:score).try(:round)
  end  
  
  def assignment_grades_attempted
    assignment_grades.where(:score != 0).count
  end

  def type
    assignment_type.try(:name)
  end
  
  
  def is_individual?
    grade_scope=="Individual"
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
  
  def has_levels?
    assignment_type.levels = 1
  end
  
end
