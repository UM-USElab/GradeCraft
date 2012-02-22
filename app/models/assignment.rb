class Assignment < ActiveRecord::Base
  has_many :grades, :dependent => :destroy
  accepts_nested_attributes_for :grades
  
  default_scope :order => 'due_date ASC'

  def mass_gradeable?
    true
  end
  
  scope :reading_reactions, where(:type => "ReadingReaction")
  scope :standard, where(:type=> "Standard")
  scope :blogging, where(:type=> "Blogging")
  scope :attendance, where(:type=> "Attendance")
  
  def assignment_grades
    Grade.where(:assignment_id => id)
  end
  
  def high_score
    assignment_grades.maximum :score
  end
  
  def low_score
    assignment_grades.minimum :score
  end

  def average 
    assignment_grades.average(:score).try(:round)
  end  
  
  def assignment_grades_attempted
    assignment_grades.where(:score != 0)
  end
  
  def percentage_complete
    assignment_grades_attempted.count
  end
  




end