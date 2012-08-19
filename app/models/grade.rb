class Grade < ActiveRecord::Base
  self.inheritance_column = 'something_you_will_not_use'
    
  belongs_to :gradeable, :polymorphic => :true
    
  #belongs_to :user
  belongs_to :assignment
  has_many :grade_scheme_elements, :through => :assignment
  has_many :earned_badges
  has_many :badges, :through => :earned_badges
  
  accepts_nested_attributes_for :earned_badges
  attr_accessible :type, :score, :feedback, :user_id, :assignment_id, :badge_id, :created_at, :updated_at, :complete, :semis, :finals, :status, :attempted, :substantial, :user, :badge_ids, :grade, :gradeable_id, :gradeable_type

  validates_presence_of :gradeable
  validates_presence_of :assignment
  
  delegate :title, :description, :point_total, :due_date, :to => :assignment
  
  after_save :save_user_score
  
  scope :completion, :joins => :assignment, :order => "assignments.due_date ASC"

   scope :attendance, where(:type => "AttendanceGrade")
   scope :reading, where(:type => "ReadingGrade")
   scope :section, where(:type=> "SectionGrade")
   scope :essays, where(:type=> "EssaysGrade")
   scope :blogging, where(:type=> "BloggingGrade")
   scope :group_project, where(:type=> "GroupProjectGrade")
   
   def grade_type
     case assignment_type_id
     when 9
       AttedanceGrade
     when 10
       ReadingGrade
     when 11
       SectionGrade
     when 12
       EssaysGrade
     when 13
       BloggingGrade
     when 14
       GroupProjectGrade
     else
       Grade
     end
   end
#     
  def score
    super || 0
  end
  
  def attempted?
    score > 0
  end
  
  def has_feedback?
    feedback != nil
  end
  
  def short?
    !substantial?
  end
  
  def save_user_score
    gradeable.save
  end
  
  def is_released?
    status == "Released"
  end
  
  def points_possible
    assignment.point_total
  end
 
  def assignment_type
    assignment.assignment_type
  end 

end
