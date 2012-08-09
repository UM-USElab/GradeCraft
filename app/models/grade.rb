class Grade < ActiveRecord::Base
  set_inheritance_column 'something_you_will_not_use'
    
  belongs_to :graded, :polymorphic => true
  belongs_to :assignment
  has_many :earned_badges
  has_many :badges, :through => :earned_badges
  
  accepts_nested_attributes_for :earned_badges
  attr_accessible :type, :score, :feedback, :user_id, :assignment_id, :badge_id, :created_at, :updated_at, :complete, :semis, :finals, :status, :attempted, :substantial, :user, :badge_ids, :grade, :graded_id, :graded_type

  validates_presence_of :user
  validates_presence_of :assignment
  
  delegate :title, :description, :point_total, :due_date, :to => :assignment
  
  after_save :save_user_score
  
  scope :completion, :joins => :assignment, :order => "assignments.due_date ASC"
  # 
#    scope :reading_reaction, where(:type => "ReadingReactionGrade")
#    scope :lfpg, where(:type=> "LFPGGrade")
#    scope :bossbattle, where(:type=> "BossBattleGrade")
#    scope :blogging, where(:type=> "BloggingGrade")
    scope :attendance, where(:type=> "AttendanceGrade")
#    scope :team_assignment, where(:type=> "TeamAssignmentGrade")
#   
#    def grade_type
#      case assignment
#      when ReadingReaction
#        ReadingReactionGrade
#      when Blogging
#        BloggingGrade
#      when Attendance
#        AttendanceGrade
#      when LFPG
#        LFPGGrade
#      when BossBattle
#        BossBattleGrade
#      when TeamAssignment
#        TeamAssignmentGrade
#      else
#        Grade
#      end
#    end
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
    user.save
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
