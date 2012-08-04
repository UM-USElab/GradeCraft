class Assignment < ActiveRecord::Base
  self.inheritance_column = 'something_you_will_not_use'
  
  has_many :grades, :dependent => :destroy
  belongs_to :course
  belongs_to :grade_scheme
  validates_presence_of :course
  belongs_to :assignment_type
  has_many :groups
  accepts_nested_attributes_for :grades
  
  default_scope :order => 'due_date ASC'
    attr_accessible :type, :title, :description, :point_total, :due_date, :created_at, :updated_at, :level, :present, :grades_attributes, :assignment_type_id, :groups_present

  def mass_gradeable?
    true
  end

  scope :team_assignment, where(:type => "TeamAssignment")
  scope :group_assignment, where(:type => "GroupAssignment")
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
  scope :graded, where(:assignment_grades.present? == 1)

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
  
  def has_groups?
    groups_present=="true"
  end
  
end
